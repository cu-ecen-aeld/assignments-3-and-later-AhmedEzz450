#!/bin/bash
<<head
accepts the following runtime arguments: 
 	1-> a path to a directory on the filesystem referred to as filesdir.
 	2-> a text string which will be searched whithin these files referred to searchstr.
exits with return value 1 error and print statements if any of the parameters above were not specified.
exits with return value 1 error and print statements if filesdir does not represent a directory on filesystem.
prints a message "The number of files are X and the number of matching lines are Y" where X is the number of
files in the directory and all subdirectories and Y is the number of matching lines found in respective files.
head


if [ ! $# -eq 2 ];
then
	echo "Error: wrong no. of arguments !!"
	echo "Enter a valid path to search into and a string to search for."
	exit 1
else
	if [ ! -d $1 ];
	then
		echo "Directory does not exist :("
		exit 1
	else
		Y=0
		L=$( find $1 -type f )
		
		for file in $L
		do
			Y=$(( $Y + $( grep -c $2 $file )))
		done
		
		X=$(  wc -l <<< "${L}" )
		echo "The number of files are $X and the number of matching lines are $Y"
		exit 0
	fi
fi
