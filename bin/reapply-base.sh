#!/usr/bin/env bash

ROOT="$(dirname $(dirname ${BASH_SOURCE[0]}))"
TOCOPY=(
  bash
  idp/logback.xml
  idp/relying-party.xml
  idp/credentials
  idp/jetty-base
  provision-base.sh
  provision-java.sh
  provision-jetty.sh
  provision-openldap.sh
)
for VAGRANT in $ROOT/idp-*; do
  if [[ $VAGRANT =~ /idp-base ]]; then
    continue
  fi
  echo "Applying base configuration to $VAGRANT"
  for F in ${TOCOPY[@]}; do
    echo cp -vR $ROOT/idp-base/$F $ROOT/$VAGRANT/
  done
done
