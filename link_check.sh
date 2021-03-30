#!/bin/bash

#get the link information from the mysql DB, and copy it into the db_link_copy file
MYSQL_COMMAND=`mysql -u YOURMSQLUSERHERE -D YOURDBNAMEEHERE -e 'SELECT * FROM DBTABLEHERE' > db_link_copy.txt`

FILENAME="db_link_copy.txt"
LINKS="only_Links.txt"

#the results will be located under /var/backups/link_backups with a timestamp
BACKUPFOLDER="/var/backups/link_backups"

keep_day=1
Curl_cmd=$(curl -o /dev/null --silent --head --write-out "%{http_code} $line\n")

#get only the link column of the table, and copy them into the only_Links file
cat $FILENAME  | cut -f5 > only_Links.txt

while read -r line;
do

#response code with the link
curl -o /dev/null --silent --head --write-out "%{http_code} $line\n" "$line" &>/dev/null


#check the response of the links
#200 means successfull, no issues on the link
#404 means the link is not found, so fail message
#403 means, token is needed, if you dont have token, you can consider it as a fail message.
Response=$(curl -o /dev/null --silent --head --write-out "%{http_code}\n" "$line")

if [ $Response == "200" ] ; then
       echo "this link works" "$line" >> $BACKUPFOLDER/linksuccess.$(date +%d-%m-%Y).txt
else
	#response code with the link:
	failed_channel_name=$(cat $FILENAME | grep "$line" | cut -f4)
	
	#copy the response code with the link and the name of the channel.
       curl -o /dev/null --silent --head --write-out "%{http_code} $line $failed_channel_name\n" "$line" >> $BACKUPFOLDER/linkfails.$(date +%d-%m-%Y).txt
fi
done < $LINKS


rm $FILENAME
rm $LINKS




