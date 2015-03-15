#!/bin/bash
set -e
source /build/scripts/scriptconfig
set -x

## Install Nginx runit service.
mkdir /etc/service/nginx
cp /build/runit/nginx /etc/service/nginx/run
cp /build/config/nginx.conf /etc/nginx/nginx.conf

mkdir /etc/service/uwsgi
cp /build/runit/uwsgi /etc/service/uwsgi/run
cp /build/config/uwsgi.conf /etc/nginx/sites-available/uwsgi.conf
rm -f /etc/nginx/sites-enabled/default 
ln -s /etc/nginx/sites-available/uwsgi.conf /etc/nginx/sites-enabled/uwsgi.conf
