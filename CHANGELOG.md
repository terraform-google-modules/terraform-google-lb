# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Changed

- Updated basic example to use [terraform-google-vm](https://github.com/terraform-google-modules/terraform-google-vm) managed instance group. [#14]

### Added

- New `health_check`, `ip_address`, and `ip_protocol` parameters. [#20]
- Introduced new lint testing and integration testing based on `terraform-google-modules` standards. [#12]

## [2.0.0] - 2019-08-02

### Changed

- Supported version of Terraform is 0.12. [#11]

## [1.0.3] - 2018-08-21


## [1.0.2] - 2017-11-08


## [1.0.1] - 2017-19-09


## [1.0.0] - 2017-08-28


[Unreleased]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/1.0.3...v2.0.0
[1.0.3]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/1.0.2...1.0.3
[1.0.2]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/GoogleCloudPlatform/terraform-google-lb/releases/tag/1.0.0
[#20]: https://github.com/terraform-google-modules/terraform-google-lb/issue/20
[#14]: https://github.com/terraform-google-modules/terraform-google-lb/issue/14
[#12]: https://github.com/terraform-google-modules/terraform-google-lb/issues/12
[#11]: https://github.com/terraform-google-modules/terraform-google-lb/issues/11
