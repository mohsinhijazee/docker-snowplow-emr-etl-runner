:logging:
  :level: {{LOG_LEVEL}} # You can optionally switch to INFO for production
:aws:
  :access_key_id: {{AWS_ACCESS_KEY}}
  :secret_access_key: {{AWS_SECRET_KEY}}
:s3:
  :region: {{S3_REGION}}
  :buckets:
    :assets: s3://snowplow-hosted-assets # DO NOT CHANGE unless you are hosting the jarfiles etc yourself in your own bucket
    :log: {{S3_LOG_BUCKET}}
    :raw:
      :in: {{S3_RAW_IN_BUCKET}}
      :processing: {{S3_RAW_PROCESSING_BUCKET}}
      :archive: {{S3_RAW_ARCHIVE_BUCKET}}    # e.g. s3://my-archive-bucket/raw
    :enriched:
      :good: {{S3_ENRICHED_GOOD_BUCKET}}       # e.g. s3://my-out-bucket/enriched/good
      :bad: {{S3_ENRICHED_BAD_BUCKET}}        # e.g. s3://my-out-bucket/enriched/bad
      :errors: {{S3_ENRICHED_ERRORS_BUCKET}}     # Leave blank unless :continue_on_unexpected_error: set to true below
    :shredded:
      :good: {{S3_SHREDDED_GOOD_BUCKET}}       # e.g. s3://my-out-bucket/shredded/good
      :bad: {{S3_SHREDDED_BAD_BUCKET}}        # e.g. s3://my-out-bucket/shredded/bad
      :errors: {{S3_SHREDDED_ERRORS_BUCKET}}     # Leave blank unless :continue_on_unexpected_error: set to true below
:emr:
  :ami_version: {{EMR_AMI_VERSION}}      # Choose as per http://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/emr-plan-ami.html
  :region: {{EMR_REGION}}        # Always set this
  :jobflow_role: EMR_EC2_DefaultRole # Created using $ aws emr create-default-roles
  :service_role: EMR_DefaultRole     # Created using $ aws emr create-default-roles
  :placement: {{EMR_PLACEMENT}}     # Set this if not running in VPC. Leave blank otherwise
  :ec2_subnet_id: {{EMR_EC2_SUBNET_ID}} # Set this if running in VPC. Leave blank otherwise
  :ec2_key_name: {{EMR_EC2_KEY_NAME}}
  :bootstrap: []           # Set this to specify custom boostrap actions. Leave empty otherwise
  :software:
    :hbase:                # To launch on cluster, provide version, "0.92.0", keep quotes
    :lingual:              # To launch on cluster, provide version, "1.1", keep quotes
  # Adjust your Hadoop cluster below
  :jobflow:
    :master_instance_type: {{EMR_JOBFLOW_MASTER_INSTANCE_TYPE}}
    :core_instance_count: {{EMR_JOBFLOW_CORE_INSTANCE_COUNT}}
    :core_instance_type: {{EMR_JOBFLOW_CORE_INSTANCE_TYPE}}
    :task_instance_count: {{EMR_JOBFLOW_TASK_INSTANCE_COUNT}} # Increase to use spot instances
    :task_instance_type: {{EMR_JOBFLOW_TASK_INSTANCE_TYPE}}
    :task_instance_bid: {{EMR_JOBFLOW_TASK_INSTANCE_BID}} # In USD. Adjust bid, or leave blank for non-spot-priced (i.e. on-demand) task instances
:etl:
  :job_name: {{ELT_JOB_NAME}} # Give your job a name
  :versions:
    :hadoop_enrich: {{ELT_VERSIONS_HADOOP_ENRICH}} # Version of the Hadoop Enrichment process
    :hadoop_shred: {{ELT_VERSIONS_HADOOP_SHRED}} # Version of the Hadoop Shredding process
  :collector_format: {{ELT_ETL_COLLECTOR_FORMAT}} # Or 'clj-tomcat' for the Clojure Collector, or 'thrift' for Thrift records, or 'tsv/com.amazon.aws.cloudfront/wd_access_log' for Cloudfront access logs
  :continue_on_unexpected_error: {{ELT_CONTINUE_ON_UNEXPECTED_ERROR}} # Set to 'true' (and set :out_errors: above) if you don't want any exceptions thrown from ETL
:iglu:
  :schema: iglu:com.snowplowanalytics.iglu/resolver-config/jsonschema/1-0-0
  :data:
    :cache_size: 500
    :repositories:
      - :name: "Iglu Central"
        :priority: 0
        :vendor_prefixes:
          - com.snowplowanalytics
        :connection:
          :http:
            :uri: http://iglucentral.com
