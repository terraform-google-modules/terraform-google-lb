# Regional TCP Load Balancer Terraform Module

Modular Regional TCP Load Balancer for GCE using target pool and forwarding rule.

## Usage

```ruby
module "gce-lb-fr" {
  source       = "github.com/GoogleCloudPlatform/terraform-google-lb"
  region       = "${var.region}"
  name         = "group1-lb"
  service_port = "${module.mig1.service_port}"
  target_tags  = ["${module.mig1.target_tags}"]
}
```

### Input variables

- `region` (optional): Region for cloud resources. Default is `us-central1`
- `network` (optional): Name of the network to create resources in. Default is `default`.
- `name` (required): Name for the forwarding rule and prefix for supporting resources.
- `service_port` (required): TCP port your service is listening on.
- `target_tags` (required): List of target tags to allow traffic using firewall rule.
- `session_affinity` (optional): How to distribute load. Options are `NONE`, `CLIENT_IP` and `CLIENT_IP_PROTO`.

### Output variables

- `target_pool`: The `self_link` to the target pool resource created.
- `external_ip`: The external ip address of the forwarding rule..

## Resources created

**Figure 1.** *diagram of terraform resources*

![architecture diagram](./diagram.png)

- [`google_compute_forwarding_rule.default`](https://www.terraform.io/docs/providers/google/r/compute_firewall.html): TCP Forwarding rule to the service port on the instances.
- [`google_compute_target_pool.default`](https://www.terraform.io/docs/providers/google/r/compute_target_pool.html): The target pool created for the instance group.
- [`google_compute_http_health_check.default`](https://www.terraform.io/docs/providers/google/r/compute_http_health_check.html): The health check for the instance group targeted at the service port.
- [`google_compute_firewall.default-lb-fw`](https://www.terraform.io/docs/providers/google/r/compute_firewall.html): Firewall that allows traffic from anywhere to instances service port.