# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).

## [3.1.0](https://github.com/terraform-google-modules/terraform-google-lb/compare/v3.0.0...v3.1.0) (2022-04-13)


### Features

* update TPG version constraints to allow 4.0 ([#40](https://github.com/terraform-google-modules/terraform-google-lb/issues/40)) ([16933d1](https://github.com/terraform-google-modules/terraform-google-lb/commit/16933d1b8a4286ed92e267c4308890a9421db611))

## [3.0.0](https://www.github.com/terraform-google-modules/terraform-google-lb/compare/v2.3.0...v3.0.0) (2021-04-01)


### ⚠ BREAKING CHANGES

* add Terraform 0.13 constraint and module attribution (#32)

### Features

* add Terraform 0.13 constraint and module attribution ([#32](https://www.github.com/terraform-google-modules/terraform-google-lb/issues/32)) ([5a3c282](https://www.github.com/terraform-google-modules/terraform-google-lb/commit/5a3c2821cb99e79247c270a812f78aaad3b8d773))

## [2.3.0](https://www.github.com/terraform-google-modules/terraform-google-lb/compare/v2.2.0...v2.3.0) (2020-04-07)


### Features

* Add list variable to override source_ips for LB ([#26](https://www.github.com/terraform-google-modules/terraform-google-lb/issues/26)) ([f640695](https://www.github.com/terraform-google-modules/terraform-google-lb/commit/f640695cd972cb3ba496582c88acc136b13fdf0c))

## [Unreleased]

## [2.2.0] - 2019-12-09

### Added

- The `target_service_accounts` variable which accepts a list of service accounts for firewall targets. [#18]

## [2.1.0] - 2019-11-26

### Added

- New `health_check`, `ip_address`, and `ip_protocol` parameters. [#20] [#22]
- Introduced new lint testing and integration testing based on `terraform-google-modules` standards. [#12]

### Changed

- Updated basic example to use [terraform-google-vm](https://github.com/terraform-google-modules/terraform-google-vm) managed instance group. [#14]

## [2.0.0] - 2019-08-02

### Changed

- Supported version of Terraform is 0.12. [#11]

## [1.0.3] - 2018-08-21


## [1.0.2] - 2017-11-08


## [1.0.1] - 2017-19-09


## [1.0.0] - 2017-08-28


[Unreleased]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/v2.2.0...HEAD
[2.2.0]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/v2.1.0...v2.2.0
[2.1.0]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/1.0.3...v2.0.0
[1.0.3]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/1.0.2...1.0.3
[1.0.2]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/GoogleCloudPlatform/terraform-google-lb/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/GoogleCloudPlatform/terraform-google-lb/releases/tag/1.0.0
[#22]: https://github.com/terraform-google-modules/terraform-google-lb/pull/22
[#20]: https://github.com/terraform-google-modules/terraform-google-lb/issues/20
[#18]: https://github.com/terraform-google-modules/terraform-google-lb/issues/18
[#14]: https://github.com/terraform-google-modules/terraform-google-lb/issues/14
[#12]: https://github.com/terraform-google-modules/terraform-google-lb/issues/12
[#11]: https://github.com/terraform-google-modules/terraform-google-lb/issues/11
