#!/bin/sh

content=$1
basename `grep -l $content /etc/local/.ssh/id_oracle_*.pub` .pub
