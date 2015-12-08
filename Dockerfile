FROM ubuntu:14.04
ENV PUPPETSERVER_JAVA_ARGS="-Xms2g -Xmx2g -XX:MaxPermSize=256m"
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y ruby-dev cron wget build-essential libsqlite3-dev && \
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb && \
dpkg -i puppetlabs-release-pc1-trusty.deb && \
apt-get update && apt-get -y install puppetserver=2.1.2-1puppetlabs1 puppetdb-terminus=2.3.8-1puppetlabs1 && rm puppetlabs-release-pc1-trusty.deb && \
/opt/puppetlabs/bin/puppetserver gem install jdbc-sqlite3 && \
/opt/puppetlabs/bin/puppetserver gem install CFPropertyList
ADD run.sh /run.sh
#ADD puppetdb.pp /puppetdb.pp
RUN chmod +x /run.sh
RUN sed -i s/START=no/START=yes/g /etc/default/puppet
RUN mkdir -p /etc/cron.d
ADD cron /etc/cron.d/
#RUN ln -sf /dev/stdout /var/log/puppetserver/puppetserver.log
#RUN ln -sf /dev/stderr /var/log/puppetserver/error.log
VOLUME ["/etc/puppetlabs/puppet", "/etc/puppetlabs/puppetserver", "/var/lib/puppet"]
#CMD /run.sh
CMD ["/opt/puppetlabs/bin/puppetserver", "foreground"]
