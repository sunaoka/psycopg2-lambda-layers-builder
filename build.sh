#!/bin/sh

set -eux

POSTGRES_VERSION=${1}
PSYCOPG2_VERSION=${2}
POSTGRES_DIR=/tmp/pg
LD_LIBRARY_PATH=${POSTGRES_DIR}/lib:${LD_LIBRARY_PATH}

cd /tmp || exit 1
curl -sL "https://ftp.postgresql.org/pub/source/v${POSTGRES_VERSION}/postgresql-${POSTGRES_VERSION}.tar.bz2" \
    | tar -jxv
curl -sL "https://github.com/psycopg/psycopg2/archive/refs/tags/$PSYCOPG2_VERSION.tar.gz" \
    | tar -zxv

cd "/tmp/postgresql-${POSTGRES_VERSION}" || exit 1
./configure --prefix "${POSTGRES_DIR}" --without-readline --without-zlib
make
make install

cd "/tmp/psycopg2-${PSYCOPG2_VERSION}" || exit 1
sed -ri -e "s!pg_config=.*!pg_config=${POSTGRES_DIR}/bin/pg_config!" setup.cfg
sed -ri -e "s!static_libpq=.*!static_libpq=1!" setup.cfg
python setup.py build

cp -pR build/lib.* /data/python
strip /data/python/psycopg2/*.so
