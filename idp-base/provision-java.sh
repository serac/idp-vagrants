#!/usr/bin/env bash

JAVA_VERSION=1.8.0_60
BUILD=b27

# Download and install JDK
MAJOR="$(echo $JAVA_VERSION | cut -d'.' -f2)"
UPDATE="$(echo $JAVA_VERSION | cut -d'_'  -f2)"
OVER="${MAJOR}u${UPDATE}"
DOWNLOAD_URL=http://download.oracle.com/otn-pub/java/jdk/$OVER-$BUILD/jdk-$OVER-linux-x64.tar.gz
TARBALL=/tmp/jdk.tar.gz
JAVA_HOME=/opt/jdk
curl -Lo $TARBALL --cookie "oraclelicense=accept-securebackup-cookie" $DOWNLOAD_URL
pushd /tmp; tar -zxvf $TARBALL; popd
mv /tmp/jdk$JAVA_VERSION $JAVA_HOME

# Download and install unlimited strength JCE policy
POLICY_URL=http://download.oracle.com/otn-pub/java/jce/$MAJOR/jce_policy-$MAJOR.zip
POLICY_ZIP=/tmp/jce_policy.zip
curl -Lo $POLICY_ZIP --cookie "oraclelicense=accept-securebackup-cookie" $POLICY_URL
pushd /tmp; $JAVA_HOME/bin/jar xvf $POLICY_ZIP; popd
mv /tmp/*JCEPolicy*/*.jar $JAVA_HOME/jre/lib/security/

# File permissions
chown -R vagrant:vagrant $JAVA_HOME

# Configure shell environment
BASHRC=/home/vagrant/.bashrc
echo >> $BASHRC
echo "# Java environment " >> $BASHRC
echo "export JAVA_HOME=\"$JAVA_HOME\"" >> $BASHRC
echo 'export PATH="$JAVA_HOME"/bin:$PATH' >> $BASHRC

