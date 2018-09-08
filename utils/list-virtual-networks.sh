#!/bin/sh

region=`/opt/farm/ext/cloud-client-oracle/utils/get-configured-region.sh`
compartment=`/opt/farm/ext/cloud-client-oracle/utils/get-compartment-id.sh`

file=/root/.oci/vcn-$region.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-8 hours' +%s` ]; then
	oci network vcn list --compartment-id $compartment >$file
fi

if [ "$1" = "--full" ]; then
	cat $file
else
	grep '"id":' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g
fi
