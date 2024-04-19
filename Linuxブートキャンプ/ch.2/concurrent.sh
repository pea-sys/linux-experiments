#!/bin/bash

if [ $# != 1 ]; then
	echo "usage: $0 <concurrency>" >&2
	exit 1
fi

CONCURRENCY=$1

taskset -p -c 0 $$ >/dev/null

for ((i=0;i<CONCURRENCY;i++)) ; do
	time ./busyloop &
done

for ((i=0;i<CONCURRENCY;i++)); do
	wait
done

