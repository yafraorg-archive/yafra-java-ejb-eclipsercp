#!/bin/sh
#
# docker run script
#
# variables must be set by CI service
# setup local environment first https://github.com/yafraorg/yafra/wiki/Development-Environment
export WORKNODE=/work/yafra-runtime

cd /work/repos/yafra-java
git pull

echo "download latest build and make it available as tomcat webapp"
# issues, tomcat users, ports and database type and config of cayenne
cd $WORKNODE
curl -O http://www.yafra.org/build/yafra-java-build.tar.gz
mv yafra-java-build.tar.gz /
cd /
tar xvfz yafra-java-build.tar.gz
# copy to tomcat

java -jar $YAFRAEXE/serverdirectclient-1.0-jar-with-dependencies.jar
java -jar $YAFRAEXE/jee-1.0-war-exec.jar -httpPort 8081 &

echo "done - running now under tomcat"
