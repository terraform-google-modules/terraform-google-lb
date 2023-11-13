# Regional TCP Proxy load balancer with Managed Instance Group Example
The example creates a managed instance group with 2 instances in the same region and a regional network TCP Load Balancer.

## Setup Terraform
* Install Terraform if it is not already installed
* `terraform init` to download plugins and set up Terraform state

## Apply Configuration
* Provide values to variables with either options:
  * with terraform.tfvars file
  * with commandline parameters
* `terraform plan` to see the infrastructure plan
* `terraform apply` to apply the infrastructure build Once complete, the load balancer IP address will display as an output


## Cleanup Resources
* `terraform destroy` to remove all resources created by terraform

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project to deploy to, if not set the default provider project is used. | `string` | `null` | no |
| region | The region of the load balancer. | `string` | `"us-east4"` | no |
| sa\_email | Service account to attach to the VM instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template#service_account. | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
