############################################################
# Dockerfile to build and install Drumbeat IFC-2LD, 
# Drumbeat Jena and Drumbeat REST API
# Based on Ubuntu 14.04 x64
############################################################

FROM ubuntu:14.04
MAINTAINER connor@jenca.io

# Update the repository sources list and install dependencies

RUN	apt-get -y install software-properties-common && \
	add-apt-repository -y ppa:openjdk-r/ppa
RUN	apt-get -y update && apt-get -y install \
		openjdk-8-jdk \
		git \
		maven

################## BEGIN INSTALLATION ######################

RUN	git clone https://github.com/Web-of-Building-Data/drumbeat-ifc2ld.git
RUN	cd drumbeat-ifc2ld && \
	git checkout develop
RUN	cd \!drumbeat-ifc2ld-parent && \
	mvn clean install

RUN	git clone https://github.com/Web-of-Building-Data/drumbeat-jena.git
RUN	cd drumbeat-jena && \
	git checkout develop
RUN	cd \!drumbeat-jena && \
	mvn clean install

RUN	git clone https://github.com/Web-of-Building-Data/drumbeat-rest-api.git
RUN	git checkout development
RUN	cd \!drumbeat-rest-api-parent && \
	mvn clean install

################## END INSTALLATION ######################

USER
EXPOSE
ENTRYPOINT