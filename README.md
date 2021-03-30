# Robust_IPTV

I created two simple bash scripts to keep my IP TV link application server up and robust.

This is a personal use project but pls feel free to use the scripts for your project as well. 


- [What's the story behind the scripts](https://github.com/gonjumixproject/git_basic/blob/main/README.md#git-quick-start )
- [What is needed to be changed in the scripts](https://github.com/gonjumixproject/git_basic/blob/main/README.md#git-basic-commands)
  * [Change link_check.sh script](https://github.com/gonjumixproject/git_basic/blob/main/README.md#starting-a-project)
  * [Change mysql_backup.sh script](https://github.com/gonjumixproject/git_basic/blob/main/README.md#starting-a-project)


# What's the story behind the scripts

I have an IP TV application on the google app store which you can watch Live TV online (https://play.google.com/store/apps/details?id=com.gonjumixproject.canlitv).

The API and mysql DB of the application is running on my digitalocean server.

The DB basicly keeps the IP TV link informations, and those two bash scripts are created to keep the DB backup and check the IP TV links on the DB to make sure the links are up.

#What is needed to be changed in the scripts

If you have a similar configuration, you will need to make some small changes in the scripts.

##Change link_check.sh script

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

##Change mysql_backup.sh script

You will need to change below for your config;

```
# Notification email address
recipient_email="youremain"

# MySQL user
user=mysqlusername

# MySQL password
password="mysqlyourpass"
```

