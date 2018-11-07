# CCRPC PostGIS Image

A PostGIS Docker image based on [mdillon/postgis][1].

## Backup

The backup script creates a monthly base backup and removes base backups and
WAL files older than one year old. Run it using:

```
docker-compose exec postgis sh -c "backup.sh"
```

## Restore

To create a restore container:

```
docker-compose run --rm \
  --name postgis_restore \
  postgis \
  sh -c "restore.sh 2018-11-05 20:00:00"
```

## Credits
The CCRPC PostGIS Image was developed by Matt Yoder for the Champaign County
Regional Planning Commission (CCRPC).

## License
The CCRPC PostGIS Image is available under the terms of the [BSD 3-clause
license][2].

[1]: https://github.com/appropriate/docker-postgis
[2]: https://github.com/champaigncountyrpc/ccrpc-postgis/blob/master/LICENSE.md
