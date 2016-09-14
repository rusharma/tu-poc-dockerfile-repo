FROM centos:7

USER root


RUN yum -y install java-1.8.0-openjdk-devel \
                &&  rm -rf /var/cache/yum/*

ENV JAVA_HOME /usr/lib/jvm/java-openjdk
ENV JRE_HOME /usr/lib/jvm/java-openjdk/jre
ENV PATH ${PATH}:/usr/lib/jvm/java-openjdk/bin:/usr/lib/jvm/java-openjdk/jre/bin


ENV CATALINA_HOME /usr/local/tomcat8/apache-tomcat-8.0.37
ENV PATH /usr/local/tomcat8/apache-tomcat-8.0.37/bin:${PATH}

RUN mkdir -p "/usr/local/tomcat8"

RUN yum install wget -y \
                        && cd /tmp \
                        && wget http://www.us.apache.org/dist/tomcat/tomcat-8/v8.0.37/bin/apache-tomcat-8.0.37.tar.gz \
                        && tar xzf apache-tomcat-8.0.37.tar.gz \
                        && mv apache-tomcat-8.0.37 /usr/local/tomcat8

WORKDIR /usr/local/tomcat8/apache-tomcat-8.0.37/webapps

RUN  wget https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war

EXPOSE 8080

WORKDIR /usr/local/tomcat8/apache-tomcat-8.0.37

CMD ["catalina.sh", "run"]

