#!/bin/bash

ICEVER=${ICEVER:-ice35}

# Ice installation
if [ "$ICEVER" = "ice35" ]; then
	#start-recommended
	curl -o /etc/yum.repos.d/zeroc-ice-el7.repo \
	http://download.zeroc.com/Ice/3.5/el7/zeroc-ice-el7.repo

	yum -y install ice ice-python ice-servers
	#end-recommended
elif [ "$ICEVER" = "ice35-devel" ]; then
	curl -o /etc/yum.repos.d/zeroc-ice-el7.repo \
	http://download.zeroc.com/Ice/3.5/el7/zeroc-ice-el7.repo

	yum -y install ice ice-python-devel ice-java-devel ice-servers
elif [ "$ICEVER" = "ice36" ]; then
	cd /etc/yum.repos.d
	wget https://zeroc.com/download/rpm/zeroc-ice-el7.repo

	#for omero, to remove when we do not install from git
	yum -y install git
	#yum -y groupinstall "Development tools"
	yum -y install gcc-c++
	yum -y install libdb-utils
	yum -y install openssl-devel bzip2-devel expat-devel

	yum -y install ice-all-runtime ice-all-devel

	pip install zeroc-ice

	echo /opt/Ice-3.6.2/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
	ldconfig
fi