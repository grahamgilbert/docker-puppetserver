#!/bin/bash
IP=`ifconfig eth1 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`
echo $IP
# Install Docker
curl -sSL https://get.docker.com/ubuntu/ | sudo sh
# wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
# dpkg -i puppetlabs-release-trusty.deb
# apt-get update
# apt-get install -y puppetserver
# Pull latest versions of your images
docker pull grahamgilbert/puppetserver

# Stop and delete all existing containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
sleep 5

docker run -d \
  -v /usr/local/docker/puppetserver/puppet:/etc/puppet \
  -v /usr/local/docker/puppetserver/puppetserver:/etc/puppetserver \
  -v /usr/local/docker/puppetserver/lib:/var/lib/puppet \
  --name="puppetserver" \
  --restart="always" \
  -p 0.0.0.0:8140:8140 \
  -h puppet.grahamgilbert.com \
  grahamgilbert/puppetserver
