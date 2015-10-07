#!/usr/bin/env bash

VERSION=3.2.0-SNAPSHOT
IDP_HOME=/opt/shibboleth-idp

function download() {
  echo "Downloading $1 to $2"
  curl -fo "$2" "$1"
  [[ $? -ne 0 ]] && echo "Artifact not found. Aborting." && exit
}

# Downloads the latest snapshot of the given snapshot version
function download_snapshot() {
  MD="$TMPDIR/maven-metadata.xml"
  curl -fo "$MD" "$SNAPSHOT_REPO/$GRP_ID/$ART_ID/$1/maven-metadata.xml"
  [[ $? -ne 0 ]] && echo "Snapshot metadata not found. Aborting." && exit
  LATEST=$(xmllint --shell "$MD" \
    <<< `echo 'cat //metadata/versioning/snapshotVersions/snapshotVersion[1]/value/text()'` \
    | grep ${VERSION%-SNAPSHOT})
  download "$SNAPSHOT_REPO/$GRP_ID/$ART_ID/$1/$ART_ID-$LATEST.$TYPE" "$2"
}

# Install dependencies
apt-get --yes install libxml2-utils

# Download and unpack IdP distribution tarball and run installer
: ${TMPDIR:="/tmp"}
RELEASE_REPO=https://build.shibboleth.net/nexus/content/repositories/releases
SNAPSHOT_REPO=https://build.shibboleth.net/nexus/content/repositories/snapshots
GRP_ID=net/shibboleth/idp
ART_ID=idp-distribution
TYPE=tar.gz
FILE="$ART_ID-$VERSION.$TYPE"
DOWNLOAD="$TMPDIR/$FILE"
if [[ $VERSION =~ .*-SNAPSHOT ]]; then
  download_snapshot $VERSION $DOWNLOAD
else
  download "$RELEASE_REPO/$GRP_ID/$ART_ID/$VERSION/$FILE" "$DOWNLOAD"
fi
pushd $TMPDIR
echo "Unpacking IdP $VERSION"
tar -zxvf $DOWNLOAD
mv shibboleth-identity-provider-$VERSION $IDP_HOME
popd
chown -R vagrant:vagrant $IDP_HOME

# Apply custom IdP configuration
su --login vagrant -c "cp -vR /vagrant/idp/* $IDP_HOME/"
su --login vagrant -c "$IDP_HOME/bin/build.sh -Didp.target.dir=$IDP_HOME"

# Set up shell environment
BASHRC=/home/vagrant/.bashrc
echo >> $BASHRC
echo "# IdP environment " >> $BASHRC
echo "export IDP_HOME=\"$IDP_HOME\"" >> $BASHRC
echo 'export PATH="$IDP_HOME"/bin:$PATH' >> $BASHRC
echo "export JETTY_BASE=\"$IDP_HOME/jetty-base\"" >> $BASHRC

# Start IdP
su --login vagrant -c "jetty.sh start"
