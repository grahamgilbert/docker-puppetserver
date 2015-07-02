#!/bin/bash

cat << EOF >> /etc/default/puppetserver
###########################################
# Init settings for puppetserver
###########################################

# Location of your Java binary (version 7 or higher)
JAVA_BIN="/usr/bin/java"

# Modify this if you'd like to change the memory allocation, enable JMX, etc
JAVA_ARGS="$PUPPETSERVER_JAVA_ARGS"

# These normally shouldn't need to be edited if using OS packages
USER="puppet"
INSTALL_DIR="/usr/share/puppetserver"
CONFIG="/etc/puppetserver/conf.d"
BOOTSTRAP_CONFIG="/etc/puppetserver/bootstrap.cfg"
SERVICE_STOP_RETRIES=60

# START_TIMEOUT can be set here to alter the default startup timeout in
# seconds.  This is used in System-V style init scripts only, and will have no
# effect in systemd.
# START_TIMEOUT=120
EOF

# ${PUPPETDB_PORT_8081_TCP_ADDR:="null"}
# if [ ! $PUPPETDB_PORT_8081_TCP_ADDR -eq "null" ]
# then
#     #sed -i s/'<<PUPPETDB>>'/'$PUPPETDB_PORT_8081_TCP_ADDR:PUPPETDB_PORT_8081_TCP_PORT'/g /puppetdb.pp
#     puppet apply /puppetdb.pp
# fi

puppetserver foreground
