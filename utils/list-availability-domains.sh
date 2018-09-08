#!/bin/sh

region=`/opt/farm/ext/cloud-client-oracle/utils/get-configured-region.sh`
compartment=`/opt/farm/ext/cloud-client-oracle/utils/get-compartment-id.sh`

file=/root/.oci/availability-domains-$region.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-8 hours' +%s` ]; then
	oci iam availability-domain list --compartment-id $compartment >$file
fi

grep '"name":' $file |awk '{ print $2 }' |sed s/\"//g |sort
