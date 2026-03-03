#!/usr/bin/env bash
set -e

docker-compose down -v || true
rm -rf /root/task || true

echo "Cleanup completed"
