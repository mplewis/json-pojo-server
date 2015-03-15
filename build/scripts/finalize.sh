#!/bin/bash
set -e
source /build/scripts/scriptconfig
set -x

apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /build
