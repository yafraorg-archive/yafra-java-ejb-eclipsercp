#!/bin/sh
#
# LOCAL BUILD
# used for CI services like Jenkins, Shippable, Travis-CI
#
# variables must be set by CI service
# setup local environment first https://github.com/yafraorg/yafra/wiki/Development-Environment
export BASENODE=/work/repos/yafra-java
export WORKNODE=/work/yafra-runtime
#export SYSADM=/work/repos/git/yafra/org.yafra.sysadm
#export YAFRATOOLS=$SYSADM/defaults
#export YAFRABIN=$SYSADM/defaults/scripts
export YAFRADOC=$WORKNODE/doc
export YAFRAMAN=$WORKNODE/man
export YAFRAEXE=$WORKNODE/bin
    
export PATH=$PATH:$YAFRABIN:$YAFRAEXE

echo "JAVA / Maven build starting"
echo "environment is WORKNODE = $WORKNODE - BASENODE = $BASENODE"
test -d $WORKNODE/apps || mkdir -p $WORKNODE/apps
test -d $WORKNODE/bin || mkdir -p $WORKNODE/bin

# set database server here
export DBSERVER=$DB_PORT_3306_TCP_ADDR
#export DBSERVER=192.168.9.10
sed -i.bup 's/localhost/'"$DBSERVER"'/' org.yafra.server.core/src/main/resources/cayenne-org_yafra.xml

# maven build - build all and run some extras afterwards
mvn install

# yafra java core
cd org.yafra.server.core/target
cp *.jar $WORKNODE/apps
# yafra java J2EE wicket and cxf
cd ../../org.yafra.server.jee/target
cp *.war $WORKNODE/apps
cp *.jar $WORKNODE/bin
# yafra java EJB3
cd $BASENODE/org.yafra.server.ejb/target
cp *client.jar $WORKNODE/apps
cd $BASENODE/org.yafra.server.ejb-war/target
cp *.war $WORKNODE/apps

#
# start yafra test first as this creates the tables if they are still missing
echo "============================================================"
echo " TEST CASE 1: Yafra db access with data operation and test data fill"
echo "============================================================"
java -jar $YAFRAEXE/serverdirectclient-1.0-jar-with-dependencies.jar

echo "============================================================"
echo " TEST CASE 2: starting server processes (JEE)"
echo "============================================================"
#java -jar $YAFRAEXE/jee-1.0-war-exec.jar -httpPort 8081 &
#cd $BASENODE/org.yafra.server.ejb-war
#mvn tomee:start

#
# test yafra components
#
#run java tests
echo "============================================================"
echo " TEST CASE 3: java utils, ejb, ws"
echo "============================================================"
java -jar $YAFRAEXE/tests-utils-1.0-jar-with-dependencies.jar
#java -jar $YAFRAEXE/tests-ejb3-1.0-jar-with-dependencies.jar localhost


echo "done - save in /work"
