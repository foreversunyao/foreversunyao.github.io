---
layout: post
title: "CI/CD on cloud"
date: 2021-03-24 20:10:06
description: ci, cd, cloud, k8s, spinnaker, jenkins, git
tags:
 - release
---
##  workflow
1. git and jenkins integration
- github has webhook(https://jenkins-hostname/jenkins/github-webhook/) for jenkins on issue comments, pull requests, pushes, repositories
- Webhooks allow external services to be notified when certain events happen. When the specified events happen, we’ll send a POST request to each of the URLs you provide.
- git repo has Jenkinsfile, the pipeline written by groovy, has a few functions
  like getLastestChangeForReleaseBranch, extractImagesToPush, generateManifests and uploadArtifactory, generateManDiff and other checks
```
pipeline {
  agent {
    kubernetes {
      inheritFrom ''
      defaultContainer ''
      yamlFile ''
    }
  }
  options {
        buildDiscarder(logRotator(daysToKeepStr: '180'))
        disableResume()
        disableConcurrentBuilds()
        timeout(time: 2, unit: "HOURS")
        timestamps()
  }
  parameters {
  }
  environment {
  }
  stages {
  }

}
```
- jenkins has github plugin, and using git repo URL. Build strategies is for change requests

2. workflow
- git change/commit ->  jenkins build job -> ecr/artifactory
- jenkins build job completed -> spinnaker ci pipeline --> notify
- stg/prod need to be deployed manually with autocheck
- static data sync->validation(data mismatch?)->core->aws(core)->wait->canaries->edge(compute/edge)

3. post release automated validate
- spinnaker + Kayenta(NetflixACAJudge-v1.0) + prometheus
- compare metrics in 30 mins window 1h before and 1h after release
- aggregate the deltas(1min as a step) and present a deviation percentage like 5% increase/decrease
```
"canary": {
               "direction": "increase",
               "effectSize": {
                  "measure": {
                     "meanRatio": {
                        "allowedIncrease": 1.05
                     }
                  }
               }
            }

## stats
      "id": "04b0e62a-ff79-4049-9a21-5255209cf8eb",
          "classification": "High",
          "classificationReason": "client 95P Latency  was classified as High",
          "groups": [
            "latency"
          ],
          "experimentMetadata": {
            "stats": {
              "count": 118,
              "mean": 0.010708477810414636,
              "min": 0.010344544224266856,
              "std": 0.0002897940416165438,
              "max": 0.011797092230084483
            }
          },
          "controlMetadata": {
            "stats": {
              "count": 118,
              "mean": 0.010572165892032992,
              "min": 0.010239771461040957,
              "std": 0.0003575595490242263,
              "max": 0.011810502473931313
            }
          },
          "resultMetadata": {
            "ratio": 1.0128934713826583
          },
          "critical": false
        },
```
- NetflixACAJudge-v1.0, experimentData is from new release and controlData is from before metrics release
```
 "scopes": {
      "control": {
        "startTimeIso": "2022-02-01T23:59:00Z",
        "startTimeMillis": 1643759940000,
        "stepMillis": 60000
      },
      "experiment": {
        "startTimeIso": "2022-02-02T00:59:00Z",
        "startTimeMillis": 1643763540000,
        "stepMillis": 60000
      }
    },
```
- generate a score of how many metrics passed the threshold by weight of groups(error:60, latency:40). pass 95
- prometheus query
```
 histogram_quantile(
        0.95, sum by (app, status, le) (
          rate(latency_seconds_bucket{type="search", status="OK", %(commonPromFilters)s}[10m])
        )
      )
```
4. access
- at halyard config enable ldap/github for authn and authz
- kubeconfig with context, user is role_arn(IAM)
- kubectl --> aws eks get-token to get authN token -> kubeapi use the token to ask IAM verify and get kube user through aws-auth configmap, then ask RBAC for authorization
- aws-auth configmap for IAM(arn) and username/groups(Subjects in clusterolebinding) in eks

- Spinnaker
1. Spinnaker is an open-source, multi-cloud continuous delivery platform that helps you release software changes with high velocity and confidence.
2. deployed by helm
```
helm install --name my-release stable/spinnaker --timeout 600 ## install the chart
helm install --name my-release -f values.yaml stable/spinnaker ## configuration
kubectl apply -f < (helmfile -e env template --skip-deps)
```
3. halyard is a tool for configuring, installing and updating spinnaker
4. Bill of Materials(BOM) to express which versions of each microservices have been validated together
```
artifactSources
dependencies
services
timestamp
version
```
5. microservices
```
* *clouddriver* - Does the communication with the Kubernetes clusters
* *deck* - Serves the UI
* *echo* - Event streamer
* *fiat* - Authorization
* *front50* - Metadata for applications, pipelines, etc.
* *gate* - API Server for all communicatoin
* *igor* - For handling CI events
* *minio* - S3-compatible backend for front50
* *orca* - Orchestration server for managing pipeline execution
* *redis* - Cache for applications, pipelines, accounts, users
* *rosco* - Image baking
* *halyard* - Configures Spinnaker
```
6. create a spinnaker pipeline
```
spin pipeline save -f <filename>
```
7. a simple pipeline template
```
id, metadata(des,name,owner,scope)
pipeline(git repo,branch, ci build number, clustername)
stages(name,refId,requisiteStageRefIds,type)
grafana(annotate)
cloudprovider(kubernetes,manifestartifact)
```
8. parameters
```
git_repo
git_branch
build_num
ticket
skip_xx
component
```
9. troubleshoot
- drill down the pipeline and find an error message
- deployment exceeded its progress deadline - look at pod's logs or increase <progressDeadlineSeconds>
```
kubectl patch deployment/nginx-deployment -p '{"spec":{"progressDeadlineSeconds":600}}'
```
- through spinnaker UI, infra -> <Unhealthy> -> edit <Pod Actions>
- YAML failure
- Unable to download contents of artifact
- Canary Analysis failed -> related to talk to Thanos instance
- spinnaker rollback --> Clouddriver may have problems talking to Clouddriver MySQL
- Pipeline template is invalid
- Deploy Manifest timeout --> connection between spinnaker and k8s timeout
- Jenkins build job failed
- OOM --> jenkins job OOM
10. Kayenta
- Kayenta is a platform for Automated Canary Analysis (ACA)
- need canary feature
11. access
- store other kubeconfig as secrets in on-prem k8s or s3 on cloud
