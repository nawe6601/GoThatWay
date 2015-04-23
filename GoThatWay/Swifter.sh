#!/bin/bash
# Swifter - simple Swift autodoc HTML generator
# GoThatWay Team
#
# Run: ./Swifter <swiftfile>
#
# Uses: /** to start block
# Then: description starting on next line, can be multiple lines
# then: :param: <parameter name> <parameter description>
# then: :returns: <description of return value> 
# and: */ to end

if (($# == 1)) && [[ -f "$1" ]]; then

    outfile="$1.html"
    echo "<html>" > $outfile
    echo "<h3>AutoDoc for file: $1</h3>" >> $outfile
    echo "<h5>Swifter v.1, by GoThatWay team</h5>" >> $outfile
    echo "<head>" >> $outfile
    echo '<style type="text/css">' >> $outfile
    echo 'body, td {' >> $outfile
    echo '    font-family: "Arial", sans-serif;' >> $outfile
    echo '}' >> $outfile
    echo 'table {' >> $outfile
    echo '    border-style:solid;' >> $outfile
    echo '    border-width: 2px;' >> $outfile
    echo '    border-collapse: collapse;' >> $outfile
    echo '    vertical-align: top;' >> $outfile
    echo '}' >> $outfile
    echo 'td {' >> $outfile
    echo '    padding: 5px;' >> $outfile
    echo '    vertical-align: top;' >> $outfile
    echo '}' >> $outfile
    echo 'tr:nth-child(odd) {' >> $outfile
    echo '    background-color:lightgray;' >> $outfile
    echo '}' >> $outfile
    echo "</style>" >> $outfile
    echo "</head>" >> $outfile

    echo "<body>" >> $outfile
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
            echo "<h3>Function $funcnum: <em>${line[1]%%(*}</em></h3>" >> $outfile 
            echo '<table><tr><td><strong>Declaration:</strong></td><td>' >> $outfile
            echo "${line[@]:0:$((${#line[@]} - 1))}" >> $outfile
            echo "</td></tr>$outstr" >> $outfile
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
                    outstr+="<em>${line[@]:1:1}  </em> ${line[@]:2}<br><br>"
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
    echo "</body>" >> $outfile
    echo "</html>" >> $outfile
    weasyprint $outfile "$1.pdf"
else
    #Print usage if files are bad
    echo "Usage: ./Swifter.sh swiftfile"
fi
