#init
gcloud init
#auth
gcloud auth login
# List projects
gcloud projects list
# To set a different default project
gcloud config set project $PROJECT

# Check configs
gcloud config configurations list

# List clusters eg.
gcloud container clusters list --region us-central1 --project <project>

# List container subnets eg.
container subnets list-usable --network-project <network> --project <project>

# generate kubeconfig
gcloud container clusters get-credentials <cluster> --region us-central1 --project <project>
KUBECONFIG=~/.kube/gcp/xx gcloud container clusters get-credentials <> --region us-central1 --project <project>

