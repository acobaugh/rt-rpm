#!/bin/bash

function fail {
	if [ $1 -ne 0 ] ; then
		echo Failed
		echo Cleaning up...
		rm -rf $tmp
		exit 1
	fi
}

read VERSION RELEASE <<< $(git describe | perl -pe 's/v([0-9.]+)(-.*)?/$1/')
fail $?

tmp=$(mktemp -d /tmp/rt-rpm-XXXX)
echo Temporary directory is $tmp
fail $?

mkdir $tmp/SPECS $tmp/SOURCES
fail $?

echo Creating tarball of shipyard
tar -czf $tmp/SOURCES/rt-shipyard.tar.gz rt-shipyard
fail $?

cat rt.spec | sed -e "s/__VERSION__/$VERSION/;s/__RELEASE__/$RELEASE/" > $tmp/SPECS/rt.spec
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
