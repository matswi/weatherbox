#!/bin/sh -e
docker build --tag weatherbox https://raw.githubusercontent.com/matswi/weatherbox/master/Dockerfile
docker run --hostname $(hostname) --interactive --rm --tty --privileged weatherbox