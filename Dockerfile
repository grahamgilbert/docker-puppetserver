FROM ubuntu:14.04
ENV PUPPETSERVER_JAVA_ARGS="-Xms2g -Xmx2g -XX:MaxPermSize=256m"
RUN apt-get update -y && apt-get install -y ruby-dev cron wget build-essential libsqlite3-dev && \
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb && \
dpkg -i puppetlabs-release-trusty.deb && \
apt-get update && apt-get -y install puppetserver puppetdb-terminus && rm puppetlabs-release-trusty.deb && \
puppetserver gem install jdbc-sqlite3 && \
puppetserver gem install CFPropertyList
ADD run.sh /run.sh
ADD puppetdb.pp /puppetdb.pp
RUN chmod +x /run.sh
RUN sed -i s/START=no/START=yes/g /etc/default/puppet
RUN mkdir -p /etc/cron.d
ADD cron /etc/cron.d/
#RUN ln -sf /dev/stdout /var/log/puppetserver/puppetserver.log
#RUN ln -sf /dev/stderr /var/log/puppetserver/error.log
VOLUME ["/etc/puppet", "/etc/puppetserver", "/var/lib/puppet"]
CMD /run.sh
