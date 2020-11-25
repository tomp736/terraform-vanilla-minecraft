#!/bin/sh
. ./shvars

time_stamp=$(date +%Y-%m-%d-%T)
mkdir -p "${backupdir}/${time_stamp}"

ssh ${username}@${ipv4_address} 'docker stop mc'
scp -r ${username}@${ipv4_address}:/mcdata/server/* "${backupdir}/${time_stamp}"
echo ${time_stamp} > $last_backup_path
ssh ${username}@${ipv4_address} 'docker start mc'