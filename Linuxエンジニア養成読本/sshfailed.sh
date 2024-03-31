#!/bin/sh

LOGFILE=/var/log/secure
MATCH_STR="Failed password"
EXTRACT_STR=".* sshd.*Failed password for *from \([0-9.]*\) port .*"

tmplogfile=`mktemp -t tmp.XXXXXXXXXX` || exit 1

grep "$MATCH_STR" $LOGFILE > $tmplogfile 2> /dev/null

if [ -s $tmplogfile ]; then
        sed -n "s/$EXTRACT_STR/\1/p" $tmplogfile | sort | uniq -c | sort -nr
else    
        echo "no match"
fi      

rm -f $tmplogfile

exit 0