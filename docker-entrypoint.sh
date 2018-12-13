#!/usr/bin/env bash

set -e

/etc/init.d/ssh start

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

if [ "$1" = "" ]
then
    if [ ! -d "/dfs/data/current" ]; then
        bin/hdfs namenode -format
    fi

    sbin/start-dfs.sh

    echo "*******************"
    echo "Hadoop DFS started"
    echo "*******************"
    tail -f /dev/null
else
	eval "$@"
fi