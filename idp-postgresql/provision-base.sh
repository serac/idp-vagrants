#!/usr/bin/env bash

SRCDIR=/vagrant/bash
for F in $SRCDIR/*; do
  su vagrant -c "cp -f $F /home/vagrant/.$(basename $F)"
done
