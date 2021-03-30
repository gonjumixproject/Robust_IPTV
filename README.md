# Robust_IPTV

I created two simple bash scripts to keep my IP TV link application server up and robust.

This is a personal use project but pls feel free to use the scripts for your project as well. 


- [What's the story behind the scripts](https://github.com/gonjumixproject/Robust_IPTV#whats-the-story-behind-the-scripts)
- [What is needed to be changed in the scripts](https://github.com/gonjumixproject/Robust_IPTV#what-is-needed-to-be-changed-in-the-scriptss)
  * [Change link_check.sh script](https://github.com/gonjumixproject/Robust_IPTV#change-link_checksh-script)
  * [Change mysql_backup.sh script](https://github.com/gonjumixproject/Robust_IPTV#change-mysql_backupsh-script)
- [ToDo](https://github.com/gonjumixproject/Robust_IPTV#todo)

# What's the story behind the scripts

I have an IP TV android application on the google app store which you can watch Live TV online. [Click the link and make sure to give a 5 stars pls :)](https://play.google.com/store/apps/details?id=com.gonjumixproject.canlitv).

The API and mysql DB of the application is running on my digitalocean server.

The DB basicly keeps the IP TV links, and those two bash scripts are created to keep the DB backups and check the IP TV links on the DB to make sure the links are up.

Dont forget to configure your cronjob to run the scripts automaticly.

# What is needed to be changed in the scripts

If you have a similar configuration, you will need to make some small changes in the scripts.

## Change link_check.sh script

If you have a similar mysql db table, you will need to change the below part of the code with your information.

```
MYSQL_COMMAND=`mysql -u YOURMSQLUSERHERE -D YOURDBNAMEEHERE -e 'SELECT * FROM DBTABLEHERE' > db_link_copy.txt`
```

You will need to change;
```
YOURMSQLUSERHERE
YOURDBNAMEEHERE
DBTABLEHERE
```

Also the channel_url's are at the 5th column of the table in my case, as an example;

```
id      cat_id  channel_type    channel_title   channel_url 
```

Thats why -f5 is used to get the urls, if you have a different type of db config, dont forget to change it for your config
```
cat $FILENAME  | cut -f5 
```

## Change mysql_backup.sh script

You will need to change below for your config;

```
# Notification email address
recipient_email="youremain"

# MySQL user
user=mysqlusername

# MySQL password
password="mysqlyourpass"
```

# ToDo
- Create case statement to make the script selective for One Link Check, Name of the Channel Check, and All Links Check
- To be able to update the not working links with correct links automaticly

