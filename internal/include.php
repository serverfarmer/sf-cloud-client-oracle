<?php

function execute($script, $param)
{
	$path = "/opt/farm/ext/cloud-client-oracle/utils";
	$_param = escapeshellarg($param);
	return trim(shell_exec("$path/$script $_param"));
}

function decode_instance($instance)
{
	$states = array(
		"PROVISIONING" => "starting",
		"RUNNING" => "running",
		"TERMINATED" => "terminated",
		"TERMINATING" => "terminated",
	);

	if (empty($instance["lifecycle-state"]))
		$state = "pending";
	else
		$state = str_replace(array_keys($states), array_values($states), $instance["lifecycle-state"]);

	// TODO: build some dynamic map for it
	$zones = array(
		"phx" => "us-phoenix-1",
		"iad" => "us-ashburn-1",
		"fra" => "eu-frankfurt-1",
		"lhr" => "uk-london-1",
	);

	$zone = str_replace(array_keys($zones), array_values($zones), $instance["region"]);
	$type = $instance["shape"];
	$name = $instance["display-name"];

	$rawkey = $instance["metadata"]["ssh_authorized_keys"];
	$tmp = explode(" ", $rawkey);
	$key = execute("get-key-name-by-content.sh", $tmp[1]);

	$id = $instance["id"];
	$host = execute("get-instance-ip.sh", $id);
	if (empty($host))
		$host = "-";

	$image = $instance["image-id"];
	$version = execute("get-ubuntu-version-by-image-id.sh", $image);
	if (empty($version))
		$version = $image;

	echo "$host $state $key $zone $type $id $version\n";
}
