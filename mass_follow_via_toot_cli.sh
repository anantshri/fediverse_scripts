#!/bin/bash
CNT=1
RATE_LIMIT=30
FILE_NAME=accounts.json
for i in `cat $FILE_NAME | jq '.[]["handles"]' | rg -v "\[\]" | rg -v "\[|\]" | tr -d '"'`
do 
    toot follow "$i" &
    CNT=`expr $CNT + 1`
    if [ `expr $CNT % $RATE_LIMIT` -eq 0 ]
    then
        echo "Pausing @@ $CNT for jobs to be done"
        wait
   fi
done
