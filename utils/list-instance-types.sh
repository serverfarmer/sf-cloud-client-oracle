#!/bin/sh

compartment=`/opt/farm/ext/cloud-client-oracle/utils/get-compartment-id.sh`

file=/root/.oci/instance-types.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-8 hours' +%s` ]; then
	oci compute shape list --compartment-id $compartment --all >$file
fi

grep '"shape":' $file |awk '{ print $2 }' |sed s/\"//g |sort
