#!/bin/sh
#-------------------------------------------------------------------------------
#  Copyright 2012 yafra.org
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
# LOCAL BUILD
# used for local builds on your machine

echo "JAVA / Maven shippable build starting"

#-------------------------------------------------------------------------------
#
# setup local environment first https://github.com/yafraorg/yafra/wiki/Development-Environment
export BASENODE=/home/shippable/workspace/src/github.com/yafraorg/yafra-java
export WORKNODE=/work/yafra-runtime
export SYSADM=/work/repos/yafra/org.yafra.sysadm
export YAFRATOOLS=$SYSADM/defaults
export YAFRABIN=$SYSADM/defaults/scripts
export YAFRADOC=$WORKNODE/doc
export YAFRAMAN=$WORKNODE/man
export YAFRAEXE=$WORKNODE/bin
export PATH=$PATH:$YAFRABIN:$YAFRAEXE
echo "environment is WORKNODE = $WORKNODE - BASENODE = $BASENODE"
test -d $WORKNODE/apps || mkdir -p $WORKNODE/apps
test -d $WORKNODE/bin || mkdir -p $WORKNODE/bin


#-------------------------------------------------------------------------------
#
# BUILD WITH DERBY AND RUN TESTS AND PACKAGE
#
# copy derby cayenne config as default
cp org.yafra.server.core/src/main/resources/cayenne-org_yafra-embedded.xml org.yafra.server.core/src/main/resources/cayenne-org_yafra.xml

# maven build - build all and run some extras afterwards
mvn clean install
if [ $? -eq 0 ]
then
  echo "Successfully build with maven"
else
 echo "Error during maven build" >&2
 exit 1
fi

# yafra java core
echo "JAVA / Maven copy runtimes to runtime directory"
cd org.yafra.server.core/target
cp *.jar $WORKNODE/apps
# yafra java J2EE wicket and cxf
cd ../../org.yafra.server.jee/target
cp *.war $WORKNODE/apps
cp *.jar $WORKNODE/bin
# yafra java EJB3
cd $BASENODE/org.yafra.server.ejb/target
cp *.jar $WORKNODE/apps
cd $BASENODE/org.yafra.server.ejb-war/target
cp *.war $WORKNODE/apps
#rcp
cd $BASENODE/org.yafra.rcpbuild
./build-rcp.sh

#
# start yafra test first as this creates the tables if they are still missing
echo "============================================================"
echo " TEST CASE 1: Yafra db access with data operation and test data fill"
echo "============================================================"
java -jar $YAFRAEXE/serverdirectclient-1.0-jar-with-dependencies.jar

#echo "============================================================"
#echo " TEST CASE 2: starting server processes (JEE)"
#echo "============================================================"
cp $WORKNODE/apps/org.yafra.server.jee.war /work/apache-tomcat-8.0.15/webapps
cp $WORKNODE/apps/org.yafra.server.ejb.jar /work/apache-openejb-4.7.1/apps
echo "start tomcat and openejb now"
echo "start tomcat /work/apache-tomcat-8.0.15/bin/startup.sh"
echo "start ejb /work/apache-openejb-4.7.1/bin/openejb start"
#java -jar $YAFRAEXE/jee-1.0-war-exec.jar -httpPort 8081 &
#cd org.yafra.server.ejb-war
#mvn tomee:start
#cd -

echo "============================================================"
echo " TEST CASE 3: java utils, ejb, ws"
echo "============================================================"
java -jar $YAFRAEXE/tests-utils-1.0-jar-with-dependencies.jar
echo "run ejb test with java -jar $YAFRAEXE/tests-ejb3-1.0-jar-with-dependencies.jar localhost"


echo "done - save in /work"
