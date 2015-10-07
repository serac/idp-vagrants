#/usr/bin/env bash

apt-get --yes install postgresql

# Overlay custom PG configuration and restart
VERSION=$(dpkg -s postgresql | grep Version | sed 's/Version: \([0-9]\.[0-9]\).*/\1/')
cp -vR /vagrant/etc/postgresql/* /etc/postgresql/$VERSION/main/
service postgresql restart

su postgres -c "createuser vagrant --createdb --no-password"
su vagrant -c "createdb idp"
