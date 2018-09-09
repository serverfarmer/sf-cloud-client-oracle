#!/bin/sh

ls /etc/local/.ssh/id_oracle_* 2>/dev/null |grep -v \.pub$ |sed s/\\\/etc\\\/local\\\/.ssh\\\/id_oracle_//g
