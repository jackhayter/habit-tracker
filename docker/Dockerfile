# Base image from Alpine for small size, with ruby preinstalled
FROM ruby:2.6.5-alpine

# Install dependancies for nokogiri, mysql2, and rmagick gems
RUN apk --update add \
  tzdata build-base \
  postgresql-client postgresql-dev \
  libxml2 libxslt \
  git \
  gdbm musl ruby-dbm gdbm-dev \
  nodejs npm \
  && gem update --system \
  && gem update \
  && gem install bundler

# Create the application user
RUN chmod 777 /usr/local/bin/bundle
RUN chmod 777 -R /usr/local/bundle
RUN adduser user -D

# Install gems separately so that the layer is cached by Docker
COPY Gemfile* /tmp/
WORKDIR /tmp
RUN npm install -g yarn
RUN bundle install

# Copy the application code and set ownership
WORKDIR /home/user/app
COPY . /home/user/app
RUN chown -R user:user /home/user/app

# Switch user and install gems
USER user
RUN bundle install

# Expose application and debug ports
EXPOSE 3000
EXPOSE 1234
EXPOSE 26162

# Default command to do nothing keeps container running
CMD tail -f /dev/null
