#!/bin/sh
. ./shvars

## create file with 
#username=
#ip_address=
#backupdir=

time_stamp=$(date +%Y-%m-%d-%T)
mkdir -p "${backupdir}/${time_stamp}"

ssh ${username}@${ip_address} 'docker stop mc'
scp -r ${username}@${ip_address}:/mcdata/* "${backupdir}/${time_stamp}"
echo ${time_stamp} > ${backupdir}/lastbackup
ssh ${username}@${ip_address} 'docker start mc'