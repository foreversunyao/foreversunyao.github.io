---
layout: post
title: "K8s helm"
date: 2021-11-24 12:25:06
description: Kubernetes Helm
tags:
 - devops
---

**What is Helm**
[git](https://github.com/helm/helm)
Helm is a tool for managing Charts. Charts are packages of pre-configured Kubernetes resources.
Helm - apt
Charts - debian package

package manager 
templating engine
release manager

[history](https://helm.sh/blog/helm-3-preview-pt1/)

**Best Practice**
[summary](https://codefresh.io/docs/docs/new-helm/helm-best-practices/)
[details](https://helm.sh/docs/intro/)

**Helm concepts**
Helm is organized around several key concepts:
A chart is a package of pre-configured Kubernetes resources
A release is a specific instance of a chart which has been deployed to the cluster using Helm
A repository is a group of published charts which can be made available to others

**Helm components(helm2)**
- Helm Client - allows developers to create new charts, manage chart repositories, and interact with the tiller server.
- Tiller Server - runs inside the Kubernetes cluster. Interacts with Helm client, and translates chart definitions and configuration to Kubernetes API commands. Tiller combines a chart and its configuration to build a release. Tiller is also responsible for upgrading charts, or uninstalling and deleting them from the Kubernetes cluster.



**Helm in Kubernetes**
![img]({{ '/assets/images/cloud/helm-k8s.png' | relative_url }}){: .center-image }*(°0°)*
![components](https://www.aquasec.com/wiki/display/containers/Kubernetes+Helm+101?preview=/9601131/9601186/image2018-5-11_10-2-46.png)

**Example**
[refer](https://medium.com/htc-research-engineering-blog/a-simple-example-for-helm-chart-fbb5c7208e94)
[charts](https://github.com/helm/charts)
```
what-the-helm
├── Chart.yaml 
├── charts
├── templates
│   ├── NOTES.txt
│   ├── _helpers.tpl
│   ├── deployment.yaml
│   ├── ingress.yaml
│   ├── service.yaml
│   └── tests
│       └── test-connection.yaml
└── values.yaml

Chart.yaml - the metadata for your Helm Chart.
values.yaml - values that can be used as variables in your templates.
templates/*.yaml - Example Kubernetes manifests.
_helpers.tpl - helper functions that can be used inside the templates.
templates/NOTES.txt - templated notes that are displayed on Chart install.

```
```
helm install --values=my-values.yaml <chartname>
helm install --set version=2.0.0
````
**Helm chart testing(WIP)**

**Helm chart production**

**Release Management**
- helm install <chartname>
- helm upgrade <chartname> --> changes are applied to existing deployment instead
of creating a new one
- helm rollback <chartname>  --> handling rollbacks

**Helmfile**
[repo](https://github.com/roboll/helmfile)
a helm for helm, helmfile is used to deploy collections of charts.
helmfile.yaml is a declarative configuration file that makes it easier to deploy and manage a large number of helm charts.

[demo](https://medium.com/@orbiran/helmfile-653a1fa2ee8e)

```
root
├── environments
│   ├── commons.yaml
│   │
│   ├── development
│   │   ├── charts.yaml
│   │   ├── kafka.yaml
│   │   ├── magic-ns.yaml
│   │   ├── nginx-ingress-internal.yaml
│   │   ├── nginx-ingress-public.yaml
│   │   └── zookeeper.yaml
│   │
│   └── staging
│       ├── charts.yaml
│       ├── magic-ns.yaml.gotmpl
│       ├── nginx-ingress-internal.yaml.gotmpl
│       └── nginx-ingress-public.yaml.gotmpl
│
└── helmfile.d - Read about single directory
    ├── 00-init.yaml
    ├── 01-infra.yaml
    ├── 02-db.yaml
    ├── 03-backend.yaml
    └── 04-data.yaml
```

## helm secrets
1. helm plugin https://github.com/futuresimple/helm-secrets
2. PGP to generate key pair(read from vault)
3. create .sops.yaml with fingerprint
```
creation_rules:
    -pgp:"9B08 DC57 18C3 8BA1 160D  EE53 4115 C1D9 D94B D9B2"
```
4. create a file secrets and encrypt
```
helm secrets enc secrets.yaml
```
5. decrypt
```
helm secrets dec values.yaml
```
## spinnaker access
1. spinnaker is running on a k8s cluster
2. other clusters kubeconfig are stored in that cluster as secrets, or using S3 on cloud
```
kubectl create secret generic --from-file=$HOME/.kube/config my-kubeconfig
kubeConfig:
  enabled: true
  secretName: my-kubeconfig
  secretKey: config
  contexts:
  # Names of contexts available in the uploaded kubeconfig
  - my-context
  # This is the context from the list above that you would like
  # to deploy Spinnaker itself to.
  deploymentContext: my-context
```
## Halyard BOM
1. Spinnaker uses a Bill of Materials to describe the services that are part of a release.
2. Halyard is a tool for configuring, installing, and updating Spinnaker, similar to helm
```
├── bom-yaml-1.19.4.tar.gz   ## bom yaml files
├── halyard.sh               ## halyard init script
├── halyard.yaml             ## halyard config
├── ingress.yaml             ## spinnaker ingress
└── install.sh               ## install
```
