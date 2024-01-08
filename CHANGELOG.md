# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).

## [4.1.0](https://github.com/terraform-google-modules/terraform-google-lb/compare/v4.0.2...v4.1.0) (2024-01-03)


### Features

* add a submodule to support proxy based regional external load balancer ([#77](https://github.com/terraform-google-modules/terraform-google-lb/issues/77)) ([a21f56d](https://github.com/terraform-google-modules/terraform-google-lb/commit/a21f56de7e0776256aa6d1bbececc1aeaff6696b))


### Bug Fixes

* **deps:** Update Terraform Google Provider to v5 (major) ([#81](https://github.com/terraform-google-modules/terraform-google-lb/issues/81)) ([753d324](https://github.com/terraform-google-modules/terraform-google-lb/commit/753d324c11a44950db975bcb539c647472d5ccbe))

## [4.0.2](https://github.com/terraform-google-modules/terraform-google-lb/compare/v4.0.1...v4.0.2) (2023-10-20)


### Bug Fixes

* upgraded versions.tf to include minor bumps from tpg v5 ([#72](https://github.com/terraform-google-modules/terraform-google-lb/issues/72)) ([fb54a8f](https://github.com/terraform-google-modules/terraform-google-lb/commit/fb54a8f99968ab589c4b033a3b0be1d7b47ba634))

## [4.0.1](https://github.com/terraform-google-modules/terraform-google-lb/compare/v4.0.0...v4.0.1) (2023-01-20)


### Bug Fixes

* fixes lint issues and generates metadata ([#59](https://github.com/terraform-google-modules/terraform-google-lb/issues/59)) ([6d55969](https://github.com/terraform-google-modules/terraform-google-lb/commit/6d55969ccae1b2cdecb9aba13dcf0b3a5f4ccefd))

## [4.0.0](https://github.com/terraform-google-modules/terraform-google-lb/compare/v3.1.0...v4.0.0) (2022-06-22)


### ⚠ BREAKING CHANGES

* New requirement for the google-beta provider (#45)

### Features

* Adds support for labels ([#45](https://github.com/terraform-google-modules/terraform-google-lb/issues/45)) ([08b00ea](https://github.com/terraform-google-modules/terraform-google-lb/commit/08b00ea2c93d9427ea4b89ee9d4f392d4198e967))

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
