#!/bin/bash

function fail {
	if [ $1 -ne 0 ] ; then
		echo Failed
		echo Cleaning up...
		rm -rf $tmp
		exit 1
	fi
}

read VERSION RELEASE SCMVERSION <<< $(git describe | perl -nle 'print "$1 $2 $3" if /v([0-9.]+)-?([0-9]+)?-?([0-9]+-.+)?/')
fail $?

echo VERSION = $VERSION
echo RELEASE = $RELEASE
echo SCMVERSION = $SCMVERSION

# prepend a dot if SCMVERSION is not empty
if [ -n "$SCMVERSION" ] ; then
	SCMVERSION=".$(echo $SCMVERSION | sed -e 's/-/_/g')"
fi

tmp=$(mktemp -d /tmp/rt-rpm-XXXX)
echo Temporary directory is $tmp
fail $?

mkdir $tmp/SPECS $tmp/SOURCES
fail $?

echo Creating tarball of shipyard
tar -czf $tmp/SOURCES/rt-shipyard.tar.gz rt-shipyard
fail $?

cat rt.spec | sed -e "s/__VERSION__/$VERSION/;s/__RELEASE__/$RELEASE/;s/__SCMVERSION__/$SCMVERSION/" > $tmp/SPECS/rt.spec
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
