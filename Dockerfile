FROM java:7-jre

MAINTAINER Daniel Zohar <daniel@memrise.com>

RUN apt-get update \
    && apt-get install -y curl \
    && apt-get install -y build-essential bison openssl libreadline5 \
                          libreadline-dev curl git-core zlib1g zlib1g-dev libssl-dev \
                          libxslt-dev libxml2-dev libpq-dev subversion autoconf

RUN set -e && \
    apt-get update -y && \
    apt-get install -y make \
    build-essential \
    python-setuptools \
    python2.7-dev && \
    easy_install envtpl


# Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
    && curl -L https://get.rvm.io | bash -s stable

# Install ruby, bundler
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 1.9.3 --default"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Checkout Snowplow repo
RUN git clone git://github.com/snowplow/snowplow.git

WORKDIR snowplow/3-enrich/emr-etl-runner
RUN /bin/bash -l -c "bundle install --deployment"
RUN /bin/bash -l -c "bundle exec bin/snowplow-emr-etl-runner --version"

RUN mkdir /etc/snowplow/
RUN mkdir /etc/snowplow/enrichments
COPY conf/config.yml.tpl /etc/snowplow/config.yml.tpl
COPY conf/enrichments /etc/snowplow/enrichments
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

