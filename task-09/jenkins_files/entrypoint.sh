#!/bin/bash

/etc/init.d/jenkins start &
groupadd -g `stat -c %g /var/run/docker.sock` docker_host && usermod -a -G docker_host jenkins
tail -F /var/log/jenkins/jenkins.log
