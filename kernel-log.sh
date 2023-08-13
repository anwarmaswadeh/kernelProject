#!/bin/bash

current_datetime=$(date +"%Y-%m-%dT%H-%M")

log_file="kernel-logs-$current_datetime.txt"
log_path="/var/log/$log_file"

compressed_file="kernel-logs-$current_datetime.tar.bz2"
compressed_path="/var/log/$compressed_file"

journalctl -k --since "1 hour ago" > "$log_path"

tar -cjf "$compressed_path" "$log_path"

dbxcli put "$compressed_path" "/dbxcli/anwar-kernel/$compressed_file"

rm "$log_path" "$compressed_path"
