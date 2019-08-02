# Regional TCP Load Balancer Terraform Module

Modular Regional TCP Load Balancer for GCE using target pool and forwarding rule.

<a href="https://concourse-tf.gcp.solutions/teams/main/pipelines/tf-examples-lb-basic" target="_blank">
<img src="https://concourse-tf.gcp.solutions/api/v1/teams/main/pipelines/tf-examples-lb-basic/badge" /></a>

## Compatibility

 This module is meant for use with Terraform 0.12. If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html)
 and need a Terraform 0.11.x-compatible version of this module, the last released version intended for
 Terraform 0.11.x is [1.0.3](https://github.com/GoogleCloudPlatform/terraform-google-lb/releases/tag/1.0.3)

## Usage

```ruby
module "gce-lb-fr" {
  source       = "GoogleCloudPlatform/lb/google"
  region       = "${var.region}"
  name         = "group1-lb"
  service_port = "${module.mig1.service_port}"
  target_tags  = ["${module.mig1.target_tags}"]
}
```

## Resources created

**Figure 1.** *diagram of terraform resources*

![architecture diagram](https://raw.githubusercontent.com/GoogleCloudPlatform/terraform-google-lb/master/diagram.png)

- [`google_compute_forwarding_rule.default`](https://www.terraform.io/docs/providers/google/r/compute_forwarding_rule.html): TCP Forwarding rule to the service port on the instances.
- [`google_compute_target_pool.default`](https://www.terraform.io/docs/providers/google/r/compute_target_pool.html): The target pool created for the instance group.
- [`google_compute_http_health_check.default`](https://www.terraform.io/docs/providers/google/r/compute_http_health_check.html): The health check for the instance group targeted at the service port.
- [`google_compute_firewall.default-lb-fw`](https://www.terraform.io/docs/providers/google/r/compute_firewall.html): Firewall that allows traffic from anywhere to instances service port.
