#!/usr/bin/env bash

ENRICHMENT_FILES=/etc/snowplow/enrichments/templates/*.json

envtpl < /etc/snowplow/config.yml.tpl > /etc/snowplow/config.yml

for file in $ENRICHMENT_FILES
do
    filename=$(basename "$file")
    envtpl < $file > "/etc/snowplow/enrichments/$filename"
done

rm /etc/snowplow/*.tpl
rm -r /etc/snowplow/enrichments/templates

/bin/bash -l -c "bundle exec bin/snowplow-emr-etl-runner $SP_SKIP --config /etc/snowplow/config.yml"
