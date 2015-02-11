#!/bin/sh
#
# docker run script
#
# variables must be set by CI service
# setup local environment first https://github.com/yafraorg/yafra/wiki/Development-Environment
export BASENODE=/work/repos/git/yafra-java
export WORKNODE=/work/yafra-runtime

echo "JAVA / Maven docker run script starting"


echo "done - save in /work"
