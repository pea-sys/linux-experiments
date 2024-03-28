#!/bin/sh

LOGFILE=$1
MAXCNT=$2

if [ ! -f $LOGFILE ]; then
        echo "File not found"
        exit 1
fi

if [  -f $LOGFILE.$MAXCNT.gz ]; then
        rm -rf $LOGFILE.MAXCNT.gz
fi

cnt=$(($MAXCNT - 1))
while [ $cnt -ge 0 ];
do
        if [  -f $LOGFILE.$cnt.gz ]; then
                mv $LOGDILE.$cnt.gz $LOGFILE.$(($cnt+1)).gz
        fi
        cnt=$(($cnt - 1))
done

mv $LOGFILE $LOGFILE.0
gzip $LOGFILE.0

touch $LOGFILE
chmod 640 $LOGFILE

exit 0