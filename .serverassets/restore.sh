#!/bin/sh
. ./shvars

last_backup_dir="$backupdir/$last_backup"

if [ -d "$last_backup_dir" ]; then
    ssh ${username}@${ipv4_address} 'docker stop mc'
    scp -r ${last_backup_dir}/* ${username}@${ipv4_address}:/mcdata/server
    ssh ${username}@${ipv4_address} 'docker start mc'
fi