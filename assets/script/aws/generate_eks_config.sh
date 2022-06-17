#!/bin/bash
AWS_PROFILE=
region_code=
cluster_name=
account_id=

cluster_endpoint=$(aws eks describe-cluster \
    --region $region_code \
    --name $cluster_name \
    --query "cluster.endpoint" \
    --output text)

certificate_data=$(aws eks describe-cluster \
    --region $region_code \
    --name $cluster_name \
    --query "cluster.certificateAuthority.data" \
    --output text)

#!/bin/bash
read -r -d '' KUBECONFIG <<EOF
apiVersion: v1
clusters:
- cluster:
    server: $cluster_endpoint
    certificate-authority-data: $certificate_data
  name: arn:aws:eks:$region_code:$account_id:cluster/$cluster_name
contexts:
- context:
    cluster: arn:aws:eks:$region_code:$account_id:cluster/$cluster_name
    user: arn:aws:eks:$region_code:$account_id:cluster/$cluster_name
  name: arn:aws:eks:$region_code:$account_id:cluster/$cluster_name
current-context: arn:aws:eks:$region_code:$account_id:cluster/$cluster_name
kind: Config
preferences: {}
users:
- name: arn:aws:eks:$region_code:$account_id:cluster/$cluster_name
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      args:
        - --region
        - "$region_code"
        - eks
        - get-token
        - --cluster-name
        - "$cluster_name"
        command: aws
        env:
        - name: "AWS_PROFILE"
          value: "$AWS_PROFILE"
EOF
echo "${KUBECONFIG}" > ~/.kube/config_$cluster_name

aws eks update-kubeconfig --region $region_code --name $cluster_name --role-arn arn:aws:iam::$account_id:role/k8s-user
