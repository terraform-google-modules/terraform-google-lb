# terraform-google-lb
This is a collection of opinionated submodules that can be used to provision load balancers in GCP.
* [TCP load balancer](./modules/tcp)
* [HTTP/S load balancer](https://github.com/terraform-google-modules/terraform-google-lb-http)
* [Internal load balancer](https://github.com/terraform-google-modules/terraform-google-lb-internal)

## Compatibility
This module is meant for use with Terraform 0.12. If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html) and need a Terraform 0.11.x-compatible version of these submodules is:
* TCP load balancer: [1.0.3](https://github.com/terraform-google-modules/terraform-google-lb/releases/tag/1.0.3)

## Examples
Examples of how to use these modules can be found in the [examples](./examples) folder.

## Contributing
Read the [contribution guidelines](./CONTRIBUTING.md) for information on contributing to this module.
