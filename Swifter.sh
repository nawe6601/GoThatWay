#!/bin/bash
#Jesse Wisniewski

if (($# == 2)) && [[ -f "$1" ]]; then

	echo "<html>" > $2
	echo "<h2>AutoDoc for $1</h2><br>" > $2

	#out=""
	i=1
	found="no"
	printline="yes"
	while read line
	do
		if [ "$found"  ==  "no" ] ; then
			strt=$(cut -c-3 <<< "$line")
			if [ "$strt"  ==  "/**" ] ; then
				found="yes"		
				echo "<table border="1">" >> $2
				echo "<tr><td>Description:</td><td>" >> $2
			fi
		else
			strt=$(cut -c-2 <<< "$line")
			if [ "$strt"  ==  "*/" ] ; then
				found="no"
			echo "</td></tr></table><br>" >> $2
			else
				par=$(cut -c-7 <<< "$line")
				ret=$(cut -c-9 <<< "$line")
				if [ "$par"  =  ":param:" ] ; then
					echo "</td></tr><tr><td>Parameter:</td><td>" >> $2
					echo ${line:8:1000} >> $2
					printline="no"
				fi
				if [ "$ret"  =  ":returns:" ] ; then
					echo "</td></tr><tr><td>Returns:</td><td>" >> $2
					echo ${line:10:1000} >> $2
					printline="no"
				fi
				if [ "$printline"  =  "yes" ] ; then
					echo "$line" >> $2	
				fi
				printline="yes"
			fi
		fi
	done < $1
	echo "</html>" >> $2
else
	#Print usage if files are bad
	echo "Usage: ./Swifter.sh swiftfile outputfile"
fi
