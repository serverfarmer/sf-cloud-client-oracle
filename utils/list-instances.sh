#!/bin/sh

compartment=`/opt/farm/ext/cloud-client-oracle/utils/get-compartment-id.sh`

if [ "$1" = "--full" ]; then
	oci compute instance list --compartment-id $compartment --all
else
	oci compute instance list --compartment-id $compartment --all \
		|/opt/farm/ext/cloud-client-oracle/internal/parse-instances.php
fi
