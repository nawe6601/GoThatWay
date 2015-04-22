#!/bin/bash
#Jesse Wisniewski

if (($# == 2)) && [[ -f "$1" ]]; then

    echo "<html>" > $2
    echo "<h3>AutoDoc for file: $1</h3>" >> $2
    echo "<h5>Swifter v.0 by JSAHN</h5>" >> $2
    echo "<head>" >> $2
    echo '<style type="text/css">' >> $2
    echo 'body, td {' >> $2
    echo '    font-family: "Arial", sans-serif;' >> $2
    echo '}' >> $2
    echo 'table {' >> $2
    echo '    border-style:solid;' >> $2
    echo '    border-width: 2px;' >> $2
    echo '    border-collapse: collapse;' >> $2
    echo '    vertical-align: top;' >> $2
    echo '}' >> $2
    echo 'td {' >> $2
    echo '    padding: 5px;' >> $2
    echo '    vertical-align: top;' >> $2
    echo '}' >> $2
    echo 'tr:nth-child(odd) {' >> $2
    echo '    background-color:lightgray;' >> $2
    echo '}' >> $2
    echo "</style>" >> $2
    echo "</head>" >> $2

    echo "<body>" >> $2
    outstr="temp"
    funcnum=0
    found="no"
    printline="yes"
    funcdef="no"
    firstparam="yes"
    while read -a line
    do
        if [ "$funcdef" == "yes" ] ; then
            funcdef="no"
            funcnum=$(($funcnum+1))
            echo "<h3>Function $funcnum: <em>${line[1]%%(*}()</em></h3>" >> $2 
            echo '<table><tr><td><strong>Declaration:</strong></td><td>' >> $2
            echo "${line[@]:0:$((${#line[@]} - 1))}" >> $2
            echo "</td></tr>$outstr" >> $2
        elif [ "$found"  ==  "no" ] ; then
            if [ "${line[0]}" == "/**" ] ; then
                found="yes"        
                outstr='<tr><td><strong>Description:</strong></td><td>'
            fi
        else
            if [ "${line[0]}" == "*/" ] ; then
                found="no"
                outstr+="</td></tr></table><br>"
                funcdef="yes"
                firstparam="yes"
            else
                if [ "${line[0]}" == ":param:" ] ; then
                    if [ "$firstparam" == "yes" ] ; then
                        outstr+='</td></tr><tr>'
                        outstr+='<td><strong>Parameters:</strong></td><td>'
                        firstparam="no"
                    fi
                    outstr+="<em>${line[@]:1:1}:</em> ${line[@]:2}<br><br>"
                    printline="no"
                elif [ "${line[0]}" == ":returns:" ] ; then
                    outstr+="</td></tr><tr><td><strong>Returns:</strong></td><td>"
                    outstr+=${line[@]:1}
                    printline="no"
                fi
                if [ "$printline" == "yes" ] && [ "${#line[@]}" -ge "1" ] ; then
                    outstr+="${line[@]}<br><br>"
                fi
                printline="yes"
            fi
        fi
    done < $1
    echo "</body>" >> $2
    echo "</html>" >> $2
else
    #Print usage if files are bad
    echo "Usage: ./Swifter.sh swiftfile outputfile"
fi
