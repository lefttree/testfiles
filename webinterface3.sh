#!/bin/sh
echo "Content-type: text/html"
echo ""
MCONFIG=/usr/local/bin/mconfig
RELOAD=/etc/rcS.d/S30mwlan
SETENVFL=/usr/local/bin/setenvlinsingle
APICALL=/usr/local/cgi-bin/api_call.sh
APIREAD=/usr/local/cgi-bin/api_read.sh

##############################
############
if [ "$REQUEST_METHOD" != "GET" ]; then
    echo "<hr>Script Error:"\
     "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
     "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
    exit 1
fi
############
app=`echo "$QUERY_STRING" | sed -n 's/^.*advance=\([^&]*\).*$/\1/p'`
#low priority
port_spec0T=`echo "$QUERY_STRING" | sed -n 's/^.*port_spec0T=\([^&]*\).*$/\1/p' | sed 's/%2C/,/g' | tr '+' ' '`
port_spec0U=`echo "$QUERY_STRING" | sed -n 's/^.*port_spec0U=\([^&]*\).*$/\1/p' | sed 's/%2C/,/g' | tr '+' ' '`
port_spec0B=`echo "$QUERY_STRING" | sed -n 's/^.*port_spec0B=\([^&]*\).*$/\1/p' | sed 's/%2C/,/g' | tr '+' ' '`
#high priority
port_spec1T=`echo "$QUERY_STRING" | sed -n 's/^.*port_spec1T=\([^&]*\).*$/\1/p' | sed 's/%2C/,/g' | tr '+' ' '`
port_spec1U=`echo "$QUERY_STRING" | sed -n 's/^.*port_spec1U=\([^&]*\).*$/\1/p' | sed 's/%2C/,/g' | tr '+' ' '`
port_spec1B=`echo "$QUERY_STRING" | sed -n 's/^.*port_spec1B=\([^&]*\).*$/\1/p' | sed 's/%2C/,/g' | tr '+' ' '`

if [ "$app" == "Save+and+Apply" ]; then
	
	#low -- class 5
#	echo "$port_spec0T"_"$port_spec0U"_"$port_spec0B" | sed 's/%2C/,/g' > /dev/shm/radio/qos_5_settings
	qos_5_settingss=`echo "$port_spec0U"_"$port_spec0T"_"$port_spec0B"`
	${SETENVFL} qos_5_settings $qos_5_settingss > /dev/null
	
	if [ "$port_spec0T" ]; then		
		${APICALL} qos_class "5\",\"1\",\"$port_spec0T"
	else
		${APICALL} qos_class_reset "5\",\"1"
	fi 
	if [ "$port_spec0U" ]; then
		${APICALL} qos_class "5\",\"0\",\"$port_spec0U"
	else
		${APICALL} qos_class_reset "5\",\"0"
	fi
	if [ "$port_spec0B" ]; then
		${APICALL} qos_class "5\",\"2\",\"$port_spec0B"
	else
		${APICALL} qos_class_reset "5\",\"2"
	fi

	#high -- class 6	
#	echo "$port_spec1T"_"$port_spec1U"_"$port_spec1B" | sed 's/%2C/,/g' > /dev/shm/radio/qos_6_settings
	qos_6_settingss=`echo "$port_spec1U"_"$port_spec1T"_"$port_spec1B"`
	${SETENVFL} qos_6_settings $qos_6_settingss > /dev/null
	
	if [ "$port_spec1T" ]; then
		${APICALL} qos_class "6\",\"1\",\"$port_spec1T"
	else 
		${APICALL} qos_class_reset "6\",\"1"
	fi
	if [ "$port_spec1U" ]; then
		${APICALL} qos_class "6\",\"0\",\"$port_spec1U"
	else 
		${APICALL} qos_class_reset "6\",\"0"
	fi
	if [ "$port_spec1B" ]; then
		${APICALL} qos_class "6\",\"2\",\"$port_spec1B"
	else 
		${APICALL} qos_class_reset "6\",\"2"
	fi

	
elif [ "$app" == "Apply" ]; then
	
	#low -- class 5
#	echo "$port_spec0T"_"$port_spec0U"_"$port_spec0B" | sed 's/%2C/,/g' > /dev/shm/radio/qos_5_settings

	if [ "$port_spec0T" ]; then
		#set		
		${APICALL} qos_class "5\",\"1\",\"$port_spec0T"
	else
		#reset 
		${APICALL} qos_class_reset "5\",\"1"
	fi
	if [ "$port_spec0U" ]; then
		${APICALL} qos_class "5\",\"0\",\"$port_spec0U"
	else
		${APICALL} qos_class_reset "5\",\"0"
	fi
	if [ "$port_spec0B" ]; then
		${APICALL} qos_class "5\",\"2\",\"$port_spec0B"
	else
		${APICALL} qos_class_reset "5\",\"2"
	fi

	#high -- class 6	
#	echo "$port_spec1T"_"$port_spec1U"_"$port_spec1B" | sed 's/%2C/,/g' > /dev/shm/radio/qos_6_settings
	
	if [ "$port_spec1T" ]; then
		#set
		${APICALL} qos_class "6\",\"1\",\"$port_spec1T"
	else
		#reset 
		${APICALL} qos_class_reset "6\",\"1"
	fi
	if [ "$port_spec1U" ]; then
		${APICALL} qos_class "6\",\"0\",\"$port_spec1U"
	else 
		${APICALL} qos_class_reset "6\",\"0"
	fi
	if [ "$port_spec1B" ]; then
		${APICALL} qos_class "6\",\"2\",\"$port_spec1B"
	else 
		${APICALL} qos_class_reset "6\",\"2"
	fi
		
fi
##############################
### port_spec0 init
if [ "$port_spec0T" != "" ]; then
    echo ""
else 
    port_spec0T=`${APIREAD} qos_class "5\",\"1" | tr '_' ','`
fi

if [ "$port_spec0U" != "" ]; then
    echo ""
else 
    port_spec0U=`${APIREAD} qos_class "5\",\"0" | tr '_' ','`
fi

if [ "$port_spec0B" != "" ]; then
    echo ""
else 
    port_spec0B=`${APIREAD} qos_class "5\",\"2" | tr '_' ','`
fi

##port_spec1 init
if [ "$port_spec1T" != "" ]; then
    echo ""
else 
    port_spec1T=`${APIREAD} qos_class "6\",\"1" | tr '_' ','`
fi
if [ "$port_spec1U" != "" ]; then
    echo ""
else 
    port_spec1U=`${APIREAD} qos_class "6\",\"0" | tr '_' ','`
fi
if [ "$port_spec1B" != "" ]; then
    echo ""
else 
    port_spec1B=`${APIREAD} qos_class "6\",\"2" | tr '_' ','`
fi

###############################################

echo '<html>'
echo '<head>'
echo '<style>'
echo 'html, body {'
echo '    margin:0;'
echo '    width: 100%;'
echo '    height: 100%;'
echo '    padding:0;'
echo '    font-family: Calibri, Verdana;'
echo '    font-size: 0.9em;'
echo '}'
echo '</style>'
echo '<title>Silvus StreamCaster MIMO Radio</title>'
echo '</head>'

echo '<body>'

echo ''
echo '<h2>Quality of Service <a href='user_manual.pdf#page=22' target='_blank'><font size='2'>(?)</font></a></h2>'
echo "<form name='qosPorts' action=\"${SCRIPT}\" method=GET>"

echo '<table>'
echo "<tr><td>Low Priority: </td>
      <td>TCP</td><td> <input type='text' name='port_spec0T' value="${port_spec0T}"></td>
      <td>UDP</td><td> <input type='text' name='port_spec0U' value="${port_spec0U}"></td>
      <td>Both</td><td> <input type='text' name='port_spec0B' value="${port_spec0B}"></td> 
		</tr>"
echo "<tr><td>High Priority: </td>
      <td>TCP</td><td> <input type='text' name='port_spec1T' value="${port_spec1T}"></td>
      <td>UDP</td><td> <input type='text' name='port_spec1U' value="${port_spec1U}"></td>
      <td>Both</td><td> <input type='text' name='port_spec1B' value="${port_spec1B}"></td>     
		</tr>"
echo '</table>'

<<COMMENT
echo '<table>'
echo "<tr><td>Priority 2: </td>
      <td>TCP</td><td> <input type='text' name='port_spec2T' value="${port_spec2T}"></td>
      <td>UDP</td><td> <input type='text' name='port_spec2U' value="${port_spec2U}"></td>
      <td>Both</td><td> <input type='text' name='port_spec2B' value="${port_spec2B}"></td> 
		</tr>"
echo '</table>'

add more priorities later if needed
COMMENT

echo '<hr>'
echo '<table>'
echo '<tr><td><input type="submit" name="advance" value="Apply"></td><td></td>'
echo '<td><input type="submit" name="advance" value="Save and Apply"></td><td></td></tr>'
echo '</table>'

echo '</form>'
echo '</body>'
echo '</html>'

if [ "$app" == "Save+and+Apply" ]; then
	echo "Done."
elif [ "$app" == "Apply" ]; then
	echo "Done."
fi

