#!/bin/bash
mkdir -p /opt/backup/base
mkdir -p /opt/backup/wal

/usr/local/bin/docker-entrypoint.sh "$@"
