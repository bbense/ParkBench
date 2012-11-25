#!/bin/sh

# Check that scp is installed so chef-solo can run. 

if [ -x '/usr/bin/scp' ] 
	then
	exit 
else 
	if [ -x '/usr/bin/yum' ] ; then
		yum install openssh-clients
 	fi 
fi