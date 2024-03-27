#!/bin/sh

SERVER="www.example.com"
PORT=80
PATTERN="^HTTP/1.1 200 OK"

testserver(){
sleep 2; echo GET / HTTP/1.1
sleep 2; echo Host: $SERVER
sleep 2; echo
sleep 2; echo exit
}

tmplogfile=`mktemp -t tmp.XXXXXXXXXX` || exit 1

testserver | telnet $SERVER $PORT > $tmplogfile 2> /dev/null

grep "$PATTERN" $tmplogfile > /dev/null 2>&1
if [ $? -eq 0 ]; then
        echo "$SERVER OK"
else
        echo "$SERVER NG"
fi

rm -f $tmplogfile

exit 0