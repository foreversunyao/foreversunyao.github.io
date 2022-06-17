for project in $(gcloud projects list --format=json | jq -r '.[].projectId'); do
    for region in $(gcloud --project ${project} run regions list --format json | jq -r '.[].locationId'); do
        echo -e "\n** Generating clusters for project ${project} in region ${region}";
        for cluster in $(gcloud --project ${project} container clusters list --region ${region} --format=json | jq -r '.[].name'); do
            KUBECONFIG=~/.kube/${cluster}.yaml gcloud container clusters get-credentials ${cluster} --region ${region} --project $project
        done
    done
done
