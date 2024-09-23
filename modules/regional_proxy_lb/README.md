# External regional proxy Network Load Balancer Terraform Module
Modular regional proxy Network Load Balancer is a reverse proxy load balancer that distributes TCP traffic coming from the internet to virtual machine (VM) instances in your Google Cloud Virtual Private Cloud (VPC) network.

This submodule allows for configuring dynamic backend outside Terraform.
As such, any changes to the `backends.groups` variable after creation will be ignored.



## Compatibility

This module is meant for use with Terraform 1.3+ and tested using Terraform 1.3. If you find incompatibilities using Terraform >=1.3, please open an issue. If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v4.5.0](https://registry.terraform.io/modules/GoogleCloudPlatform/lb-http/google/4.5.0).




## Usage

```HCL
module "gce-lb-tcp" {
  source                   = "GoogleCloudPlatform/GoogleCloudPlatform/lb/google//modules/regional_proxy_lb"
  name                     = "my-tcp-lb"
  region                   = var.region
  project                  = var.project
  network_project          = var.project
  network                  = google_compute_network.default.id
  target_tags              = local.tags
  port_front_end           = 101
  create_proxy_only_subnet = false
  proxy_only_subnet_cidr   = "10.129.0.0/23"
  health_check = {
    tcp_health_check = {
      port_specification = "USE_SERVING_PORT"
    }
  }

  backend = {
    port_name    = local.port_name
    backend_type = "INSTANCE_GROUP"

    log_config = {
      enable = true
    }

    groups = [{
      group           = module.mig.instance_group
      capacity_scaler = 0.5
    }]
  }
}
```


## Resources created

**Figure 1.** _diagram of terraform resources_

![architecture diagram](/diagram.png)


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address | IP address of the external load balancer, if not provided, an ephemeral address will be created | `string` | `null` | no |
| backend | backend attributes | <pre>object({<br>    port             = optional(number)<br>    port_name        = optional(string)<br>    description      = optional(string)<br>    backend_type     = string #INSTANCE_GROUP, NETWORK_ENDPOINT_GROUP<br>    session_affinity = optional(string)<br>    timeout_sec      = optional(number)<br><br>    log_config = object({<br>      enable      = optional(bool)<br>      sample_rate = optional(number)<br>    })<br><br>    groups = list(object({<br>      group = string<br><br>      balancing_mode               = optional(string)<br>      capacity_scaler              = optional(number)<br>      description                  = optional(string)<br>      max_connections              = optional(number)<br>      max_connections_per_instance = optional(number)<br>      max_connections_per_endpoint = optional(number)<br>      max_rate                     = optional(number)<br>      max_rate_per_instance        = optional(number)<br>      max_rate_per_endpoint        = optional(number)<br>      max_utilization              = optional(number)<br>    }))<br>  })</pre> | n/a | yes |
| create\_firewall\_rules | Whether to create firewall rules for health check and proxy | `bool` | `false` | no |
| create\_proxy\_only\_subnet | Whether to create the proxy only subnet for the region | `bool` | `false` | no |
| health\_check | Health check to determine whether instances are responsive and able to do work | <pre>object({<br>    check_interval_sec  = optional(number)<br>    healthy_threshold   = optional(number)<br>    timeout_sec         = optional(number)<br>    unhealthy_threshold = optional(number)<br>    tcp_health_check = object({<br>      request            = optional(string)<br>      response           = optional(string)<br>      port               = optional(number)<br>      port_name          = optional(string)<br>      port_specification = optional(string)<br>      proxy_header       = optional(string)<br>      }<br>    )<br>    }<br>  )</pre> | n/a | yes |
| name | Name of the load balancer and prefix for supporting resources. | `string` | n/a | yes |
| network | Name of the network to create resources in. | `string` | n/a | yes |
| network\_project | Name of the project where the network resides. Useful for shared VPC. Default is var.project. | `string` | n/a | yes |
| port\_front\_end | Port of the load balancer front end | `number` | n/a | yes |
| project | The project to deploy to, if not set the default provider project is used. | `string` | `null` | no |
| proxy\_header | Specifies the type of proxy header to append before sending data to the backend. Default value is NONE. Possible values are: NONE, PROXY\_V1 | `string` | `"NONE"` | no |
| proxy\_only\_subnet\_cidr | The CIDR block of the proxy only subnet.This is required when create\_proxy\_only\_subnet is set to true. | `string` | `""` | no |
| region | Region of the created GCP resources from this module. | `string` | n/a | yes |
| target\_tags | List of target tags to allow traffic using firewall rule.This is required when create\_firewall\_rules is set to true. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| backend\_services | The backend service resources. |
| forwarding\_rule | The forwarding rule of the load balancer. |
| tcp\_proxy | The TCP proxy used by this module. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
