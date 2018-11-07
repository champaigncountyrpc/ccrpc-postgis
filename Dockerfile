FROM mdillon/postgis:11-alpine

ENV PGDATA /var/lib/postgresql/data/pgdata

VOLUME /opt/backup

COPY backup.sh /usr/local/bin/
COPY restore.sh /usr/local/bin/
COPY ccrpc-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["ccrpc-entrypoint.sh"]

CMD [ \
  "postgres", \
  "-c", \
  "wal_level=replica", \
  "-c", \
  "archive_mode=on", \
  "-c", \
  "archive_command=test ! -f /opt/backup/wal/%f && cp %p /opt/backup/wal/%f", \
  "-c", \
  "archive_timeout=3600" \
]
