# Documentation: https://heptio.github.io/ark/v0.9.0/aws-config.html

BUCKET=backup-ark-k8s
REGION=us-east-1
NAMESPACE=heptio-ark

# Create S3 bucket
aws s3api create-bucket \
    --bucket ${BUCKET} \
    --region ${REGION} 

# Create IAM user
aws iam create-user --user-name heptio-ark

# Attach policies to give heptio-ark
sed 's|${BUCKET}|'"${BUCKET}"'|g' heptio-ark-policy.txt > heptio-ark-policy.json

aws iam put-user-policy \
--user-name heptio-ark \
--policy-name heptio-ark \
--policy-document file://heptio-ark-policy.json

# Create an access key for the user
aws iam create-access-key --user-name heptio-ark

# Create a Secret with the aws credentials in k8s
kubectl create secret generic cloud-credentials \
    --namespace ${NAMESPACE} \
    --from-file cloud=k8s/secrets/credentials-ark

# start the ark server in k8s
kubectl apply -f k8s/aws/00-prereqs.yaml
kubectl apply -f k8s/aws/00-ark-config.yaml
kubectl apply -f k8s/aws/10-deployment.yaml