#!/bin/bash

SRC_DIR="$(pwd)/$(dirname $(dirname ${BASH_SOURCE[0]}))"
jmeter -n -t $SRC_DIR/etc/shibboleth-sso-test.jmx \
  -Jidphost=localhost \
  -Jidpport=8443 \
  -Jidpcontextpath=/idp \
  -Juserdataset=$SRC_DIR/etc/idp-users.csv
