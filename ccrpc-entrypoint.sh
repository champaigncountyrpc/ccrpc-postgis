#!/bin/bash
mkdir -p /opt/backup/base
chown -R "$(id -u)" /opt/backup/base
chmod 700 /opt/backup/base

mkdir -p /opt/backup/wal
chown -R "$(id -u)" /opt/backup/wal
chmod 700 /opt/backup/wal

/usr/local/bin/docker-entrypoint.sh "$@"
