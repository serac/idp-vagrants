#!/usr/bin/env bash

JETTY_VERSION=9.3.3.v20150827
JETTY_HOME=/opt/jetty
TARBALL=/tmp/jetty-dist.tar.gz

curl -o $TARBALL http://mirror.cc.columbia.edu/pub/software/eclipse/jetty/$JETTY_VERSION/dist/jetty-distribution-${JETTY_VERSION}.tar.gz
pushd /tmp; tar -zxvf $TARBALL; popd
mv /tmp/jetty-distribution-${JETTY_VERSION} $JETTY_HOME

# File permissions
chown -R vagrant:vagrant $JETTY_HOME

# Configure shell environment
BASHRC=/home/vagrant/.bashrc
echo >> $BASHRC
echo "# Jetty environment " >> $BASHRC
echo "export JETTY_HOME=\"$JETTY_HOME\"" >> $BASHRC
echo 'export PATH="$JETTY_HOME"/bin:$PATH' >> $BASHRC

