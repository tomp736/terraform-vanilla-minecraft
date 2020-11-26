#!/bin/sh
. ./shvars

if [ -f "$last_backup_path" ]; then
    scp $last_backup_path ${username}@${ipv4_address}:/mcdata/backups/last_backup 
    scp -r $backupdir/$last_backup ${username}@${ipv4_address}:/mcdata/backups
    ssh ${username}@${ipv4_address} '/mcdata/manage.sh --restore'
fi