#!/bin/bash
# This script looks at your following list and identify accounts with zero posts
# and prints them account names along with when they joined.
#!/bin/bash
toot_count (){
	USER=$1
	POSTS=`toot whois $USER 2>/dev/null | rg Statuses | cut -f2 -d":" | tr -d " "`
	JOIN_DATE=`toot whois $USER 2>/dev/null| rg "^Since" | cut -f2 -d":" | tr -d " "`
	if [ $POSTS == "0" ]
	then
		echo "$USER,$JOIN_DATE"
	fi
}
if [ `which toot` ]
then
	NAME=`toot whoami | head -n1 | cut -f1 -d" "`
	CNT=1
	for i in `toot following $NAME | cut -f2 -d" "`
	do
		CNT=$(($CNT+1))
		toot_count $i &
		if [ $(expr $CNT % 20) == "0" ]
		then
			wait
		fi
	done
else
	echo "Toot-CLI Is basis for this tool install and authenticate to it"
fi
wait
