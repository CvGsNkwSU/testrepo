#!/bin/bash

current_date="$(date +%s_%Y_%m_%d)"
backup_dir="/etc/gitlab_backups/"

## Backup gitlab configuration data.
gitlab-ctl backup-etc && cd /etc/gitlab/config_backup && mv "$(ls -t | head -n1)" $backup_dir

## Backup SSH keys.
tar -c -f /etc/ssh_$current_date.tar /etc/ssh && cd /etc && mv /etc/ssh_$current_date.tar $backup_dir

## Backup application data.
gitlab-backup create && cd /var/opt/gitlab/backups && mv "$(ls -t | head -n1)" $backup_dir # Perhaps put this in seperate cron-job, once a week or so, because it can get pretty big and idk if our server can handle it.