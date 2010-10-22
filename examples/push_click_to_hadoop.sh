#!/bin/bash

_1day_ago=`date --date '1 day ago' +%Y%m%d`
_1day_ago_category=`date --date '1 day ago' +%Y-%m-%d`
_10min_ago=`date --date '10 minute ago' +%Y%m%d%H%M`
_10min_ago_category=`date --date '10 minute ago' +%Y-%m-%d`
_10min_ago=$(($_10min_ago / 10))
_1hour_ago=`date --date '1 hour ago' +%Y%m%d%H`
_directory='/data2/log/click/'
_log_filename="*$_1day_ago*.log"
_find_cmd=`find $_directory ! \( -type d -path '*change*' -prune \) -type f -name $_log_filename|sort` 
_category=$_1day_ago_category

for file in $_find_cmd
do
	retval=`cat $file | /usr/local/bin/scribe_cat -h 10.10.155.201:1463 $_category`
	echo "$file - $retval" 
	if [ "$retval" != "OK" ]; then
		mkdir -p /daum/tmp/try_later/$_category/
		cp -rf $file /daum/tmp/try_later/$_category/
	fi
done
exit 0

