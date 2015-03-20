#!/bin/sh
#-------------------------------------------------------------------------------
#  Copyright 2015 yafra.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#-------------------------------------------------------------------------------
#
# docker run script
#
# variables must be set by CI service
# setup local environment first https://github.com/yafraorg/yafra/wiki/Development-Environment
export WORKNODE=/work/yafra-runtime
export YAFRAEXE=$WORKNODE/bin

cd /work/repos/yafra-java
git pull

echo "download latest build and make it available as tomcat webapp"
# issues, tomcat users, ports and database type and config of cayenne
cd $WORKNODE
curl -O http://www.yafra.org/build/yafra-java-build.tar.gz
mv yafra-java-build.tar.gz /
cd /
tar xvfz yafra-java-build.tar.gz

# cayenne config
# sed the localhost to $DB_PORT_3306_TCP_ADDR and $DB_PORT_3306_TCP_PORT
# jar uf serverdirectclient-1.0-jar-with-dependencies.jar cayenne-org_yafra.xml

# copy to tomcat

# run
java -jar $YAFRAEXE/serverdirectclient-1.0-jar-with-dependencies.jar
java -jar $YAFRAEXE/jee-1.0-war-exec.jar -httpPort 8081 &

echo "done - running now under tomcat"
