FROM ubuntu:14.04
ENV PUPPETSERVER_JAVA_ARGS="-Xms2g -Xmx2g -XX:MaxPermSize=256m"
RUN apt-get install -y wget ruby-dev build-essential libsqlite3-dev && \
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb && \
dpkg -i puppetlabs-release-trusty.deb && gem install sqlite3 && \
gem install CFPropertyList && \
apt-get update && apt-get -y install puppetserver && rm puppetlabs-release-trusty.deb
ADD run.sh /run.sh
RUN chmod +x /run.sh
RUN sed -i s/START=no/START=yes/g /etc/default/puppet
#RUN ln -sf /dev/stdout /var/log/puppetserver/puppetserver.log
#RUN ln -sf /dev/stderr /var/log/puppetserver/error.log
VOLUME ["/etc/puppet", "/etc/puppetserver", "/var/lib/puppet"]
CMD /run.sh
