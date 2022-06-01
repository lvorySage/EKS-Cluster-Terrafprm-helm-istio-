<!-- https://markdownlivepreview.com/ -->
# EKS with Istio, Terraform and Helm 3

### Prerequisites :

- AWS creds set with  admin user permissions (verify with aws s3 ls , it should return empty output or a bucket name)

- AWS IAM authenticator

    https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html

- AWS Cli

    https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html


- kubectl( v19-20)

    https://kubernetes.io/docs/tasks/tools/

- terraform 1.0 ( 0.15.5)
    https://www.terraform.io/downloads.html
    https://learn.hashicorp.com/tutorials/terraform/install-cli

- HELM 3 

    https://helm.sh/docs/intro/install/




### 1. AWS CLI : Create S3 bucket to store terraform state

Create S3 bucket(random salt, is generating random id to use for bucket name, as names for buckets should be globally unique ): 


    export RANDOM_SALT=$(xxd -l 5 -c 5 -p < /dev/random);
    aws s3api create-bucket --bucket tf-state-eks-$RANDOM_SALT --region us-east-1 --acl private;
    aws s3api put-public-access-block --bucket tf-state-eks-$RANDOM_SALT --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true";

Set  "bucket" value to the name of created S3 bucket in provider.tf : 

    bucket = "tf-state-eks-8b2a91c8b2"


### 2. Terraform : Download modules and initilise Terraform configuration

    terraform init

### 3. Terraform : Apply the configuration

    terraform apply

Note: If during "apply" you see a timeout to Kubernetes cluster endpoint, please check if ___"whitelisted_ip" ___ contains your current and correct IP address


### 5. Kubectl : Export the kubeconfig file, that will be generated after Terraform apply

In ___"terraform outputs"___


Run  "kubeconfig_export" command   :
    
     export KUBECONFIG=./kubeconfig_test-eks-P4k92Nq0; '. << This is just example

Run ___"eks_auth_command"___   :  

    eks_auth_command = "aws eks --region us-east-1 update-kubeconfig --name test-eks-CY6PKJ71" << This is just example

Run it and verify that connection to the cluster works 

    kubectl get po
    kubectl get ns


###   Deploy the test app 

    helm upgrade apps  ./apps --install 


### ONLY FOR Clean Up

    terraform destroy


### Additional information ; 




  