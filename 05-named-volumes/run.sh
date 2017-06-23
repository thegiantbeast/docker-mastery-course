#!/bin/sh

runPostgreSQL() {
    ts=`date +%s`
    echo "Running PostgreSQL v$1 container"
    docker container run --rm --name pgdb -v psql-data:/var/lib/postgresql/data -d postgres:$1 > /dev/null
    echo "Checking logs since $ts"
    logs="docker logs pgdb --since $ts 2>&1 | grep -q 'database system is ready to accept connections'"
    until eval "$logs"
    do
      sleep 1
    done
    echo "PostgreSQL started normally.. stopping container"
    docker container stop pgdb > /dev/null
}

runPostgreSQL 9.6.1
runPostgreSQL 9.6.2