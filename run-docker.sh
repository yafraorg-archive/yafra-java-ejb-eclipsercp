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
export CAYCONF=cayenne-org_yafra.xml

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
cp $WORKNODE/cayenne-org_yafra-localmysql.xml $WORKNODE/$CAYCONF
sed -i "/url/s/localhost/$DB_PORT_3306_TCP_ADDR/" $WORKNODE/$CAYCONF
cp $WORKNODE/$CAYCONF $YAFRAEXE
mkdir -p $WORKNODE/apps/WEB-INF/classes
cp $WORKNODE/$CAYCONF $WORKNODE/apps/WEB-INF/classes
cp $WORKNODE/org.yafra.yafraMap.map.xml $WORKNODE/apps/WEB-INF/classes

cd $YAFRAEXE
jar uf serverdirectclient-1.0-jar-with-dependencies.jar $CAYCONF
cd $WORKNODE/apps
jar uf org.yafra.server.jee.war WEB-INF/classes/$CAYCONF
jar uf org.yafra.server.jee.war WEB-INF/classes/org.yafra.yafraMap.map.xml
jar uf org.yafra.server.ejb.jar $CAYCONF

# sed tomcat port to 80 and users - done in dockerfile not here - port kept to 8080
# copy to tomcat (as war) / openejb (jar) 
cp $WORKNODE/apps/org.yafra.server.jee.war /usr/local/tomcat/webapps
cp $WORKNODE/apps/org.yafra.server.ejb.jar /usr/local/ejbserver/apps

# run
java -jar $YAFRAEXE/serverdirectclient-1.0-jar-with-dependencies.jar
/usr/local/tomcat/bin/startup.sh
/usr/local/ejbserver/bin/openejb start --ejbd-bind 0.0.0.0 &


echo "done - running now under tomcat"
