# Basic TCP Forwarding Rule Example
The example creates a managed instance group with 2 instances in the same region and a network TCP Load Balancer.

![Load Balancer Diagram](./docs/diagram.png "Load Balancer Diagram")

To provision this example, run the following from this directory or using Cloud Shell.

[![button](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/terraform-google-modules/terraform-google-lb&working_dir=examples/basic&page=shell&tutorial=README.md)

## Change to the example directory
```
[[ `basename $PWD` != basic ]] && cd examples/basic
```

## Setup Environment
* Set the project, replacing `YOUR_PROJECT` with your project ID
```
PROJECT=YOUR_PROJECT
```
```
gcloud config set project ${PROJECT}
```
* Configure the environment for Terraform
```
[[ $CLOUD_SHELL ]] || gcloud auth application-default login
export GOOGLE_PROJECT=$(gcloud config get-value project)
```

## Setup Terraform
* Install Terraform if it is not already installed
* `terraform init` to download plugins and set up Terraform state

## Apply Configuration
* `terraform plan` to see the infrastructure plan
* `terraform apply` to apply the infrastructure build Once complete, the load balancer IP address will display as an output

## Test Load Balancer
* Open the URL of the load balancer in your browser
```
echo http://$(terraform output load_balancer_default_ip)
```

## Cleanup Resources
* `terraform destroy` to remove all resources created by terraform

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| image\_family | Image used for compute VMs. | `string` | `"debian-11"` | no |
| image\_project | GCP Project where source image comes from. | `string` | `"debian-cloud"` | no |
| project\_id | GCP Project used to create resources. | `any` | n/a | yes |
| region | n/a | `string` | `"us-central1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| load\_balancer\_default\_ip | The external ip address of the forwarding rule for default lb. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
