#!/bin/sh

# Check recent version of ohai is installed so chef-solo can run. 

if [ -x '/usr/bin/ohai' ] 
	then
	/usr/bin/ohai platform_family || /usr/bin/gem update ohai
	exit 
else 
	if [ -x '/usr/bin/gem' ] ; then
		gem install ohai
 	fi 
fi