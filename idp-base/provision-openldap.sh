#!/usr/bin/env bash

ADMIN_PASS="Shibbol3th."
echo slapd slapd/password1 password "$ADMIN_PASS" | debconf-set-selections
echo slapd slapd/password2 password "$ADMIN_PASS" | debconf-set-selections
apt-get --yes install slapd ldap-utils
ldapadd -x -D cn=admin,dc=nodomain -w "$ADMIN_PASS" -f /vagrant/ldap/users.ldif
