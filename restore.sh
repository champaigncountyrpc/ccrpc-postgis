#!/bin/bash

restore_dir=/opt/restore/pgdata
fmt_msg='Please specify a restore date and time in the format YYYY-MM-DD HH:MM:SS.'

if [ -d "$restore_dir" ]; then
  echo 'Directory /opt/restore already contains data. Aborting!'
  exit 1
fi

mkdir -p $restore_dir/pg_wal

dt="$@"
if [ -z "$dt" ]; then
  echo 'Error: No restore date and time.'
  echo $fmt_msg
  exit 1
fi

echo Restoring to: $dt
now=$(date +%s)
{
  secs=$(date +%s -d"$dt")
} || {
  echo 'Error: Invalid date and time format.'
  echo $fmt_msg
  exit 1
}

mins=$((($now - $secs) / 60))
base_path=`find /opt/backup/base/*/ -type d -mmin +$mins | tail -n 1`

if [ -z "$base_path" ]; then
  echo 'Error: Could not find a base backup prior to the specified date and time.'
  exit 1
fi

echo Using base backup: $base_path

echo 'Extracting base data...'
tar xzf $base_path/base.tar.gz -C $restore_dir

echo 'Extracting base WAL...'
tar xzf $base_path/pg_wal.tar.gz -C $restore_dir/pg_wal

echo 'Writing restore configuration...'
cat <<EOF >> $restore_dir/recovery.conf
restore_command = 'cp /opt/backup/wal/%f %p'
recovery_target_time='$dt CDT'
recovery_target_action=promote
EOF

export PGDATA=/opt/restore/pgdata
/usr/local/bin/docker-entrypoint.sh "postgres"
