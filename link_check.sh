#!/bin/bash

MYSQL_COMMAND=`mysql -u YOURMSQLUSERHERE -D YOURDBNAMEEHERE -e 'SELECT * FROM DBTABLEHERE' > db_link_copy.txt`
FILENAME="db_link_copy.txt"
LINKS="only_Links.txt"
BACKUPFOLDER="/var/backups/link_backups"
keep_day=1
Curl_cmd=$(curl -o /dev/null --silent --head --write-out "%{http_code} $line\n")

cat $FILENAME  | cut -f5 > only_Links.txt

while read -r line;
do
#response code with the link
curl -o /dev/null --silent --head --write-out "%{http_code} $line\n" "$line" &>/dev/null
#only get the response code
Response=$(curl -o /dev/null --silent --head --write-out "%{http_code}\n" "$line")

if [ $Response == "200" ] ; then
       echo "this link works" "$line" >> $BACKUPFOLDER/linksuccess.$(date +%d-%m-%Y).txt
else
	#response code with the link:
	failed_channel_name=$(cat $FILENAME | grep "$line" | cut -f4)
       curl -o /dev/null --silent --head --write-out "%{http_code} $line $failed_channel_name\n" "$line" >> $BACKUPFOLDER/linkfails.$(date +%d-%m-%Y).txt
fi
done < $LINKS


rm $FILENAME
#rm $LINKS


# Delete old backups
#find $backupfolder -mtime +$keep_day -delete

