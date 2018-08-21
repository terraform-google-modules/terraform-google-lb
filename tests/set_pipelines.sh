#!/usr/bin/env bash

fly -t tf set-pipeline -p tf-examples-lb-basic -c tests/pipelines/tf-examples-lb-basic.yaml -l tests/pipelines/values.yaml
fly -t tf set-pipeline -p tf-lb-pull-requests -c tests/pipelines/tf-lb-pull-requests.yaml -l tests/pipelines/values.yaml

fly -t tf expose-pipeline -p tf-examples-lb-basic
fly -t tf expose-pipeline -p tf-lb-pull-requests