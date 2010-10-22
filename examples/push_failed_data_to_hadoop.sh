#!/bin/bash

_directory='/daum/tmp/try_later/'
_log_filename="*.log"
_find_cmd=`find $_directory -type f -name $_log_filename|sort` 

for file in $_find_cmd
do
	_category=`echo "$file"|awk -F. '{print $(NF-1)}'|sed -e 's/\([0-9][0-9][0-9][0-9]\)\([0-9][0-9]\)\([0-9][0-9]\).*/\1-\2-\3/g'`
	echo $_category
	retval=`cat $file | /usr/local/bin/scribe_cat -h 10.10.155.201:1463 $_category`
	echo "$file - $retval" 
	if [ "$retval" = "OK" ]; then
		rm -rf $file	
	fi
	#echo "ended - $file"
done
exit 0
