#
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

#
# yafra.org Java docker image
#

# source is yafra ubuntu
FROM yafraorg/docker-yafrabase

MAINTAINER Martin Weber <info@yafra.org>

# JAVA SDK part
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
RUN sudo echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -yq oracle-java8-installer maven ant && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  update-java-alternatives -s java-8-oracle  && \
  export JDK_HOME=/usr/lib/jvm/java-8-oracle


# TOMCAT part
# see https://www.apache.org/dist/tomcat/tomcat-8/KEYS
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
	05AB33110949707C93A279E3D3EFE6B686867BA6 \
	07E48665A34DCAFAE522E5E6266191C37C037D42 \
	47309207D818FFD8DCD3F83F1931D684307A10A5 \
	541FBE7D8F78B25E055DDEE13C370389288584E7 \
	61B832AC2F1C5A90F0F9B00A1C506407564C17A3 \
	79F7026C690BAA50B92CD8B66A3AD3F4F22C4FED \
	9BA44C2621385CB966EBA586F72C284D731FABEE \
	A27677289986DB50844682F8ACB77FC2E86E29AC \
	A9C5DF4D22E99998D9875A5110C01C5A2F6059E7 \
	DCFD35E0BF8CA7344752DE8B6FB21E8933C60243 \
	F3A04C595DB5B6A5F1ECA43E3B7BBB100D811BBE \
	F7DA48BB64BCB84ECBA7EE6935CD23C10D498E23
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME
ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.26
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
RUN set -x \
	&& curl -fSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
	&& curl -fSL "$TOMCAT_TGZ_URL.asc" -o tomcat.tar.gz.asc \
	&& gpg --verify tomcat.tar.gz.asc \
	&& tar -xvf tomcat.tar.gz --strip-components=1 \
	&& rm bin/*.bat \
	&& rm tomcat.tar.gz*
RUN sed -i "s#</tomcat-users>##g" conf/tomcat-users.xml; \
    echo '  <role rolename="manager-gui"/>' >>  conf/tomcat-users.xml; \
    echo '  <role rolename="manager-script"/>' >>  conf/tomcat-users.xml; \
    echo '  <role rolename="manager-jmx"/>' >>  conf/tomcat-users.xml; \
    echo '  <role rolename="manager-status"/>' >>  conf/tomcat-users.xml; \
    echo '  <role rolename="admin-gui"/>' >>  conf/tomcat-users.xml; \
    echo '  <role rolename="admin-script"/>' >>  conf/tomcat-users.xml; \
    echo '  <user username="admin" password="admin" roles="manager-gui, manager-script, manager-jmx, manager-status, admin-gui, admin-script"/>' >>  conf/tomcat-users.xml; \
    echo '</tomcat-users>' >> conf/tomcat-users.xml


# TOMEE / EJB part
ENV GPG_KEYS \
	223D3A74B068ECA354DC385CE126833F9CF64915 \
	7A2744A8A9AAF063C23EB7868EBE7DBE8D050EEF \
	82D8419BA697F0E7FB85916EE91287822FDB81B1 \
	9056B710F1E332780DE7AF34CBAEBE39A46C4CA1 \
	A57DAF81C1B69921F4BA8723A8DE0A4DB863A7C1 \
	B7574789F5018690043E6DD9C212662E12F3E1DD \
	B8B301E6105DF628076BD92C5483E55897ABD9B9 \
	DBCCD103B8B24F86FFAAB025C8BB472CD297D428 \
	F067B8140F5DD80E1D3B5D92318242FE9A0B1183 \
	FAA603D58B1BA4EDF65896D0ED340E0E6D545F97
RUN set -xe \
	&& for key in $GPG_KEYS; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	done
ENV EJB_HOME /usr/local/ejbserver
ENV PATH $EJB_HOME/bin:$PATH
RUN mkdir -p "$EJB_HOME"
WORKDIR $EJB_HOME
ENV TOMEE_VERSION 1.7.2
ENV EJB_VERSION 4.7.2
ENV EJB_TGZ_URL http://www.us.apache.org/dist/tomee/tomee-$TOMEE_VERSION/openejb-standalone-$EJB_VERSION.tar.gz
RUN set -x \
    && curl -SL "$EJB_TGZ_URL" -o ejbserver.tar.gz \
    && curl -SL "$EJB_TGZ_URL.asc" -o ejbserver.tar.gz.asc \
    && gpg --verify ejbserver.tar.gz.asc \
    && tar -xvf ejbserver.tar.gz --strip-components=1 \
    && rm bin/*.bat \
    && rm ejbserver.tar.gz*

# GIT YAFRA JAVA - TODO: replace with a binary from shippable
WORKDIR /work
RUN cd /work/repos && git clone https://github.com/yafraorg/yafra-java.git
COPY run-docker.sh /work/run-docker.sh
RUN cd /work && \
  chmod 755 run-docker.sh

# expose EJB and Tomcat port of server app
EXPOSE 4201
EXPOSE 8080

# standard start script which starts tomcat and ejb servers
CMD ["/work/run-docker.sh"]
