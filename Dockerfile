FROM phusion/baseimage:0.9.16
MAINTAINER Matthew Lewis <matt@mplewis.com>

ENV HOME /root

# Update apt-get and install necessary system packages
RUN apt-get update
RUN apt-get install -y \
    nginx \
    python3-dev \
    python3-pip \
    default-jre \
    build-essential

# Install Python 3 packages
RUN pip3 install flask uwsgi

# Download and unpack jsonschema2pojo
RUN mkdir /home/app
WORKDIR /home/app
ADD https://github.com/joelittlejohn/jsonschema2pojo/releases/download/jsonschema2pojo-0.4.8/jsonschema2pojo-0.4.8.tar.gz /home/app/jsonschema2pojo-0.4.8.tar.gz
RUN tar xvf jsonschema2pojo-0.4.8.tar.gz
RUN rm -f jsonschema2pojo-0.4.8.tar.gz

# Copy and run build scripts
RUN mkdir /build
ADD build /build
RUN /build/scripts/prepare.sh
RUN /build/scripts/nginx-uwsgi.sh
RUN /build/scripts/finalize.sh

# Add the server files
ADD app /home/app

# Start runit
CMD ["/sbin/my_init"]
