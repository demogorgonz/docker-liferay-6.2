# Liferay-portal-6.2-ce-ga3
#

# 0.0.1 : initial file with java 7u60
# 0.0.2 : change base image : java 7u71
# 0.0.3 : chain run commande to reduce image size (from 1.175 GB to 883.5MB), add JAVA_HOME env
# 0.0.4 : change to debian:wheezy in order to reduce image size (883.5MB -> 664.1 MB)
# 0.0.5 : bug with echo on setenv.sh

FROM snasello/docker-debian-java7:7u71
ENV http_proxy http://10.35.1.93:8080
ENV https_proxy http://10.35.1.93:8080
RUN apt-get update -y && apt-get upgrade -y
MAINTAINER Samuel Nasello <samuel.nasello@elosi.com>

# install liferay
RUN apt-get install -y unzip zip \
        && curl -O -s -k -L -C - http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.2.2%20GA3/liferay-portal-tomcat-jre-6.2-ce-ga3-20150115105139957.zip \
        && unzip liferay-portal-tomcat-jre-6.2-ce-ga3-20150115105139957.zip -d /opt \
        && rm liferay-portal-tomcat-jre-6.2-ce-ga3-20150115105139957.zip

# add config for bdd
RUN /bin/echo -e '\nCATALINA_OPTS="$CATALINA_OPTS -Dexternal-properties=portal-bd-${DB_TYPE}.properties"' >> /opt/liferay-portal-6.2-ce-ga3/tomcat-7.0.42/bin/setenv.sh

# add configuration liferay file
ADD https://raw.githubusercontent.com/demogorgonz/docker-liferay-6.2/master/lep/portal-bundle.properties /opt/liferay-portal-6.2-ce-ga3/portal-bundle.properties
ADD https://raw.githubusercontent.com/demogorgonz/docker-liferay-6.2/master/lep/portal-bd-MYSQL.properties /opt/liferay-portal-6.2-ce-ga3/portal-bd-MYSQL.properties
ADD https://raw.githubusercontent.com/demogorgonz/docker-liferay-6.2/master/lep/portal-bd-POSTGRESQL.properties /opt/liferay-portal-6.2-ce-ga3/portal-bd-POSTGRESQL.properties

# volumes
VOLUME ["/var/liferay-home", "/opt/liferay-portal-6.2-ce-ga3/"]

# Ports
EXPOSE 8080

# Set JAVA_HOME
ENV JAVA_HOME /opt/java

# EXEC
CMD ["run"]
ENTRYPOINT ["/opt/liferay-portal-6.2-ce-ga3/tomcat-7.0.42/bin/catalina.sh"]
