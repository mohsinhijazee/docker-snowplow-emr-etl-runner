#!/usr/bin/env bash

envtpl < /etc/snowplow/config.yml.tpl > /etc/snowplow/config.yml
/bin/bash -l -c "bundle exec bin/snowplow-emr-etl-runner $SP_SKIP --config /etc/snowplow/config.yml"
