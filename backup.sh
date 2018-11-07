#!/bin/bash

if [ ! -d /opt/backup/base/`date +%Y-%m`-* ]; then
  PGPASSWORD=$POSTGRES_PASSWORD \
    pg_basebackup -D /opt/backup/base/`date +%Y-%m-%d` \
    -Ft -z -U $POSTGRES_USER -w
fi

find /opt/backup/base/*/ -type d -mtime +366 -exec rm -rf {} +
find /opt/backup/wal/* -type f -mtime +366 -exec rm {} +
