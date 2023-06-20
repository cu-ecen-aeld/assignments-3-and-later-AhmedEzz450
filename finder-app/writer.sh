#!/bin/bash
<<head
-> Accepts the following arguments:
	1st is a full path to a file (including filename) on the filesystem, referred to below as writefile.
	2nd is a text string which will be written within this file, referred to below as writestr.
-> Exits with value 1 error and print statements if any of arguments above were not specified.
-> Creates a new file with name and path writefile with content writestr, overwriting any existing file and creating the path if it doesn't exist.
Exits with value 1 and error print statement if the file could not be created.
head

if [ $# -ne 2 ]
then
	echo "Wrong No. of arguments :( !!"
	exit 1
else
	tmp=$IFS
	IFS="/"
	dir=""
	for f in $1
	do
		FullDir+="$f""/"
		dir+="$f"
		if [ "$dir" != "$1" ]
		then
			dir+="/"
		else
			break
		fi
		if [ "$dir" = "./" ]
		then
			continue
		fi
		if [ ! -d "$dir" ]
		then
			mkdir "$dir"
			if [ $? -ne 0 ]
			then
				echo "Couldn't create directory $FullDir :( !!"
				exit 1
			fi
		fi
	done
	IFS=$tmp
	echo "$2" > $1
	if [ $? -ne 0 ]
	then
		echo "Couldn't create file: $1"
		exit 1
	fi
fi
exit 0
