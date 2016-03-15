#!/bin/bash

function fail {
	if [ $1 -ne 0 ] ; then
		echo Failed
		exit 1
	fi
}

tmp=$(mktemp -d /tmp/rt-rpm-XXXX)
echo Temporary directory is $tmp
fail $?

mkdir $tmp/SPECS $tmp/SOURCES
fail $?

echo Creating tarball of shipyard
tar -czf $tmp/SOURCES/rt-shipyard.tar.gz rt-shipyard
fail $?

cp rt.spec $tmp/SPECS
fail $?

echo Building SRPM
out=$(rpmbuild -bs --define "_topdir $tmp" $tmp/SPECS/rt.spec)
if [ $? -eq 0 ] ; then
	srpm=$(echo $out | awk '{ print $2 }')
	cp -f $srpm /tmp
	rm -rf $tmp
	echo SRPM is at /tmp/$(basename $srpm)
else
	echo Build failed. Output: $out
fi
