#!/bin/sh
# This will build a freeroute.jar file that can be executed by running
# java -jar freeroute.jar
#
set -e

ant clean
ant
ant create_jar
cd packaging/linux && make

