#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <unused>"
	exit 1
fi

osver="18.04"
/opt/farm/ext/cloud-client-oracle/utils/list-images.sh $1 $osver |head -n1
