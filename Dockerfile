FROM ruby:2.7.1-alpine3.11
LABEL maintainer="Tiryoh <tiryoh@gmail.com>"
COPY rootfs /

#
# EnvVars
# Ruby
#

ENV BUNDLE_HOME=/usr/local/bundle
ENV BUNDLE_APP_CONFIG=/usr/local/bundle
ENV BUNDLE_DISABLE_PLATFORM_WARNINGS=true
ENV BUNDLE_BIN=/usr/local/bundle/bin
ENV GEM_BIN=/usr/gem/bin
ENV GEM_HOME=/usr/gem
ARG RUBYOPT=-W0

#
# EnvVars
# Image
#

ENV JEKYLL_VAR_DIR=/var/jekyll
ARG JEKYLL_DOCKER_TAG=3.8.0
ARG JEKYLL_VERSION=3.8.0
ARG JEKYLL_DOCKER_COMMIT=null
ARG JEKYLL_DOCKER_NAME=jekyll
ENV JEKYLL_DATA_DIR=/srv/jekyll
ENV JEKYLL_BIN=/usr/jekyll/bin
ENV JEKYLL_ENV=development

#
# EnvVars
# System
#

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV TZ=America/Chicago
ENV PATH="$JEKYLL_BIN:$PATH"
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US

#
# EnvVars
# Main
#

ENV VERBOSE=false
ENV FORCE_POLLING=false
ENV DRAFTS=false

#
# Packages
# Dev
#

RUN apk --no-cache add \
  zlib-dev \
  libffi-dev \
  build-base \
  libxml2-dev \
  imagemagick-dev \
  readline-dev \
  libxslt-dev \
  libffi-dev \
  yaml-dev \
  zlib-dev \
  vips-dev \
  sqlite-dev \
  cmake

#
# Packages
# Main
#

RUN apk --no-cache add \
  linux-headers \
  openjdk8-jre \
  less \
  zlib \
  libxml2 \
  readline \
  libxslt \
  libffi \
  git \
  nodejs \
  tzdata \
  shadow \
  bash \
  su-exec \
  nodejs-npm \
  libressl \
  yarn

#
# Gems
# Update
#

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN unset GEM_HOME && unset GEM_BIN && \
  yes | gem update --system

#
# Gems
# Main
#

RUN unset GEM_HOME && unset GEM_BIN && yes | gem install --force bundler
RUN gem install jekyll -v$JEKYLL_VERSION -- \
    --use-system-libraries

# Stops slow Nokogiri!
RUN gem install html-proofer jekyll-reload jekyll-mentions jekyll-coffeescript jekyll-sass-converter jekyll-commonmark jekyll-paginate jekyll-compose jekyll-assets RedCloth kramdown jemoji -- \
  --use-system-libraries


RUN addgroup -Sg 1000 jekyll
RUN adduser  -Su 1000 -G \
  jekyll jekyll

#
# Remove development packages on minimal.
# And on pages.  Gems are unsupported.
#

RUN mkdir -p $JEKYLL_VAR_DIR
RUN mkdir -p $JEKYLL_DATA_DIR
RUN chown -R jekyll:jekyll $JEKYLL_DATA_DIR
RUN chown -R jekyll:jekyll $JEKYLL_VAR_DIR
RUN chown -R jekyll:jekyll $BUNDLE_HOME
RUN rm -rf /home/jekyll/.gem
RUN rm -rf $BUNDLE_HOME/cache
RUN rm -rf $GEM_HOME/cache
RUN rm -rf /root/.gem

# Work around rubygems/rubygems#3572
RUN mkdir -p /usr/gem/cache/bundle
RUN chown -R jekyll:jekyll \
  /usr/gem/cache/bundle

CMD ["jekyll", "--help"]
ENTRYPOINT ["/usr/jekyll/bin/entrypoint"]
WORKDIR /srv/jekyll
VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000
