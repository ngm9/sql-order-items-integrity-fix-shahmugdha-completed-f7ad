#!/usr/bin/env bash
set -e

docker-compose up -d

echo "Waiting for PostgreSQL to be ready..."

for i in {1..30}; do
  if docker exec utkrusht-sql-basic-db pg_isready -U utkrusht_user >/dev/null 2>&1; then
    echo "PostgreSQL is ready."
    exit 0
  fi
  sleep 2
done

echo "PostgreSQL did not become ready in time."
exit 1
