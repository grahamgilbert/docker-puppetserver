#!/bin/bash

# Install Docker
curl -sSL https://get.docker.com/ubuntu/ | sudo sh

# Pull latest versions of your images
docker pull grahamgilbert/puppetserver

# Stop and delete all existing containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
sleep 5

docker run -d \
  --name="puppetserver" \
  --restart="always" \
  -v /usr/local/docker/puppetserver/puppet:/etc/puppet \
  -v /usr/local/docker/puppetserver/puppetserver:/etc/puppetserver \
  -v /usr/local/docker/puppetserver/lib/puppet:/var/lib/puppet \
  -p 0.0.0.0:8140:8140 \
  -e PUPPETSERVER_JAVA_ARGS="-Xms256m -Xmx256m -XX:MaxPermSize=256m" \
  -h puppet.grahamgilbert.com \
  grahamgilbert/puppetserver
