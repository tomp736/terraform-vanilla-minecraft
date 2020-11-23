#!/bin/sh
. ./shvars

## create file with 
#username=
#ip_address=
#backupdir=

last_backup=$(cat ${backupdir}/lastbackup)
last_backup_dir="${backupdir}/${last_backup}"

if [ -d "$last_backup_dir" ]; then
    ssh ${username}@${ip_address} 'docker stop mc'
    scp -r ${last_backup_dir} ${username}@${ip_address}:/mcdata
    ssh ${username}@${ip_address} 'docker start mc'
fi