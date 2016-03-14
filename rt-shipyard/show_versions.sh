#!/bin/bash

cat shipwright/version.yml \
	| cat shipwright/version.yml \
	| sed -e ':a;N;$!ba;s/:\n/ /g' \
	| grep cpan | awk '{ print $1, $3 }' \
	| sed -e 's/cpan-//' \
	| sed -e "s/'//g" | while read module version ; do

	cpan=$(curl -G -q "http://api.metacpan.org/v0/release/_search" --data "q=distribution:$module%20AND%20status:latest&fields=name,version" 2>/dev/null | grep version | awk '{ print $3 }' | sed -e 's/"//g;s/,//g')
	
	echo -en "$module = $version\t$cpan"
	if [ -z "$cpan" ] ; then
		echo -e "\tNOVERSION"
	elif (( $(echo $cpan'>'$version | bc -l) )) ; then
		echo -e "\tNEEDS_UPDATED"
	else
		echo
	fi
done
