#!/bin/sh
echo "Content-type: text/html"
echo ""
MCONFIG=/usr/local/bin/mconfig
RELOAD=/etc/rcS.d/S30mwlan
SETENVFL=/usr/local/bin/setenvlinsingle
APICALL=/usr/local/cgi-bin/api_call.sh
APIREAD=/usr/local/cgi-bin/api_read.sh


##Temp_reporting
temp_reporting_enable=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_enable=\([^&]*\).*$/\1/p'` 
if [ "$temp_reporting_enable" != "" ]; then
    echo ""
else 
    temp_reporting_enable=`${APIREAD} temp_reporting_mode`
fi

TEMP_REPORTING_ENABLE0='';TEMP_REPORTING_ENABLE1='';

case ${temp_reporting_enable} in 
    0)
        TEMP_REPORTING_ENABLE0='selected'
        ;;
    1)
        TEMP_REPORTING_ENABLE1='selected'
        ;;
    *)
        ;;
esac 


##Temp_reporting_ip
temp_reporting_ip=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_ip=\([^&]*\).*$/\1/p'` 
if [ "$temp_reporting_ip" != "" ]; then
    echo ""
else 
    temp_reporting_ip=`${APIREAD} temp_reporting_address | cut -d"_" -f1`
fi

TEMP_REPORTING_IP='';


##Temp_reporting_port
temp_reporting_port=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_port=\([^&]*\).*$/\1/p'` 
if [ "$temp_reporting_port" != "" ]; then
    echo ""
else 
    temp_reporting_port=`${APIREAD} temp_reporting_address | cut -d"_" -f2`
fi

TEMP_REPORTING_PORT='';



##Temp_reporting_min_threshold
temp_reporting_min_threshold=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_min_threshold=\([^&]*\).*$/\1/p'` 
if [ "$temp_reporting_min_threshold" != "" ]; then
    echo ""
else 
    temp_reporting_min_threshold=`${APIREAD} temp_reporting_min_threshold`
fi

TEMP_REPORTING_MIN_THRESHOLD='';



##Temp_reporting_max_threshold
temp_reporting_max_threshold=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_max_threshold=\([^&]*\).*$/\1/p'` 
if [ "$temp_reporting_max_threshold" != "" ]; then
    echo ""
else 
    temp_reporting_max_threshold=`${APIREAD} temp_reporting_max_threshold`
fi

TEMP_REPORTING_MAX_THRESHOLD='';



##Temp_reporting_period
temp_reporting_period=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_period=\([^&]*\).*$/\1/p'` 
if [ "$temp_reporting_period" != "" ]; then
    echo ""
else 
    temp_reporting_period=`${APIREAD} temp_reporting_period`
fi

TEMP_REPORTING_PERIOD='';




##Temp_reporting_mode
temp_reporting_mode=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_mode=\([^&]*\).*$/\1/p'` 
if [ "$temp_reporting_mode" != "" ]; then
    echo ""
else 
    temp_reporting_mode=`${APIREAD} temp_reporting_mode`
fi

TEMP_REPORTING_MODE0='';TEMP_REPORTING_MODE1='';TEMP_REPORTING_MODE2='';

case ${temp_reporting_mode} in 
    0)
        TEMP_REPORTING_MODE0='selected'
        ;;
    1)
        TEMP_REPORTING_MODE1='selected'
        ;;
    2)
        TEMP_REPORTING_MODE2='selected'
        ;;

    *)
        ;;
esac 





###########RSSI report
##rssi_report_enable
rssi_report_enable=`echo "$QUERY_STRING" | sed -n 's/^.*rssi_report_enable=\([^&]*\).*$/\1/p'` 
if [ "$rssi_report_enable" != "" ]; then
    echo ""
else 
    rssi_report_enable=`${APIREAD} rssi_report_enable`
fi

RSSI_REPORT_ENABLE0='';RSSI_REPORT_ENABLE1='';

case ${rssi_report_enable} in 
    0)
        RSSI_REPORT_ENABLE0='selected'
        ;;
    1)
        RSSI_REPORT_ENABLE1='selected'
        ;;
    *)
        ;;
esac 


##rssi_report_ip
rssi_report_ip=`echo "$QUERY_STRING" | sed -n 's/^.*rssi_report_ip=\([^&]*\).*$/\1/p'` 
if [ "$rssi_report_ip" != "" ]; then
    echo ""
else 
    rssi_report_ip=`${APIREAD} rssi_report_address | cut -d"_" -f1`
fi




##rssi_report_port
rssi_report_port=`echo "$QUERY_STRING" | sed -n 's/^.*rssi_report_port=\([^&]*\).*$/\1/p'` 
if [ "$rssi_report_port" != "" ]; then
    echo ""
else 
    rssi_report_port=`${APIREAD} rssi_report_address | cut -d"_" -f2`
fi


##rssi_report_period
rssi_report_period=`echo "$QUERY_STRING" | sed -n 's/^.*rssi_report_period=\([^&]*\).*$/\1/p'` 
if [ "$rssi_report_period" != "" ]; then
    echo ""
else 
    rssi_report_period=`${APIREAD} rssi_report_period`
fi





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
echo ''
echo '<body>'


echo ''
echo '<h2>Temperature Reporting Configuration</h2>'
echo "<form name='form0' action=\"${SCRIPT}\" method=GET>"
echo '<table>'

echo "<tr><td colspan='1'>Temperature Reporting Mode</td><td> <select name='temp_reporting_mode' > <option value='0'  ${TEMP_REPORTING_MODE0} > Disable reporting<option value='1'  ${TEMP_REPORTING_MODE1} > Send report when node is heating<option value='2'  ${TEMP_REPORTING_MODE2} > Send report periodically</select></tr>"


echo "<tr><td>Temperature Reporting IP</td> <td><input type='text' name='temp_reporting_ip' value=${temp_reporting_ip}></td></tr>"

echo "<tr><td>Temperature Reporting Port</td> <td> <input type='text' name='temp_reporting_port' value=${temp_reporting_port}></td></tr>"

echo "<tr><td>Min. Temperature Threshold (C)</td> <td> <input type='text' name='temp_reporting_min_threshold' value=${temp_reporting_min_threshold}></td></tr>"

echo "<tr><td>Max. Temperature Threshold (C)</td> <td> <input type='text' name='temp_reporting_max_threshold' value=${temp_reporting_max_threshold}></td></tr>"

echo "<tr><td>Temperature Reporting Period (s)</td> <td> <input type='text' name='temp_reporting_period' value=${temp_reporting_period}></td></tr>"


echo '</table>'


echo '<tr>'
echo '  <td><input type="submit" name="checkpage0" value="Apply"></td>'
echo '  <td><input type="submit" name="checkpage0" value="Save and Apply"></td>'
echo '</tr>'

echo '</form>'



echo '<h2>RSSI Reporting Configuration</h2>'
echo "<form name='form1' action=\"${SCRIPT}\" method=GET>"
echo '<table>'
echo "<tr><td colspan='1'>RSSI Reporting</td><td> <select name='rssi_report_enable' > <option value='0'  ${RSSI_REPORT_ENABLE0} > Disable<option value='1'  ${RSSI_REPORT_ENABLE1} > Enable</select></tr>"

echo "<tr><td>RSSI Reporting IP</td> <td><input type='text' name='rssi_report_ip' value=${rssi_report_ip}></td></tr>"

echo "<tr><td>RSSI Reporting Port</td> <td> <input type='text' name='rssi_report_port' value=${rssi_report_port}></td></tr>"

echo "<tr><td>RSSI Reporting Period (ms)</td> <td> <input type='text' name='rssi_report_period' value=${rssi_report_period}> </td></tr>"

echo '</table>'


echo '<tr>'
echo '  <td><input type="submit" name="checkpage1" value="Apply"></td>'
echo '  <td><input type="submit" name="checkpage1" value="Save and Apply"></td>'
echo '</tr>'

echo '</form>'


echo '</body>'
echo '</html>'


if [ "$REQUEST_METHOD" != "GET" ]; then
    echo "<hr>Script Error:"\
    "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
    "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
    exit 1
fi



#### Set Temperature Reporting Param
X=`echo "$QUERY_STRING" | sed -n 's/^.*checkpage0=\([^&]*\).*$/\1/p'`
X0=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_enable=\([^&]*\).*$/\1/p'`
X1=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_ip=\([^&]*\).*$/\1/p'`
X2=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_port=\([^&]*\).*$/\1/p'`
X3=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_min_threshold=\([^&]*\).*$/\1/p'`
X4=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_max_threshold=\([^&]*\).*$/\1/p'`
X5=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_period=\([^&]*\).*$/\1/p'`
X6=`echo "$QUERY_STRING" | sed -n 's/^.*temp_reporting_mode=\([^&]*\).*$/\1/p'`



if [ "$X" == "Apply" ]; then

    ${APICALL} temp_reporting_address "$X1\",\"$X2"
    ${APICALL} temp_reporting_min_threshold $X3
    ${APICALL} temp_reporting_max_threshold $X4 
    ${APICALL} temp_reporting_period $X5 
    ${APICALL} temp_reporting_mode $temp_reporting_mode

    echo "Done."
elif [ "$X" == "Save+and+Apply" ]; then

    ${APICALL} temp_reporting_address "$X1\",\"$X2"                                             
    ${APICALL} temp_reporting_min_threshold $X3                                                 
    ${APICALL} temp_reporting_max_threshold $X4                                                 
    ${APICALL} temp_reporting_period $X5                                                        
    ${APICALL} temp_reporting_mode $temp_reporting_mode
    
    echo "Saving into flash ... "
    
    ${SETENVFL} temp_reporting_enable $X0 > /dev/null
    ${SETENVFL} temp_reporting_ip $X1 > /dev/null
    ${SETENVFL} temp_reporting_port $X2 > /dev/null
    ${SETENVFL} temp_reporting_min_threshold $X3 > /dev/null
    ${SETENVFL} temp_reporting_max_threshold $X4 > /dev/null
    ${SETENVFL} temp_reporting_period $X5 > /dev/null
    ${SETENVFL} temp_reporting_mode $X6 > /dev/null

    echo "Done."
fi

#### Set RSSI Reporting Param
Y=`echo "$QUERY_STRING" | sed -n 's/^.*checkpage1=\([^&]*\).*$/\1/p'`
Y0=`echo "$QUERY_STRING" | sed -n 's/^.*rssi_report_enable=\([^&]*\).*$/\1/p'`
Y1=`echo "$QUERY_STRING" | sed -n 's/^.*rssi_report_ip=\([^&]*\).*$/\1/p'`
Y2=`echo "$QUERY_STRING" | sed -n 's/^.*rssi_report_port=\([^&]*\).*$/\1/p'`
Y3=`echo "$QUERY_STRING" | sed -n 's/^.*rssi_report_period=\([^&]*\).*$/\1/p'`


if [ "$Y" == "Apply" ]; then

    ${APICALL} rssi_report_enable $Y0
    ${APICALL} rssi_report_address "$Y1\",\"$Y2"
    ${APICALL} rssi_report_period $Y3

    echo "Done."
elif [ "$Y" == "Save+and+Apply" ]; then

    ${APICALL} rssi_report_enable $Y0                                                           
    ${APICALL} rssi_report_address "$Y1\",\"$Y2"                                                
    ${APICALL} rssi_report_period $Y3 
    
    echo "Saving into flash ... "
    
    ${SETENVFL} rssi_report_enable $Y0 > /dev/null
    ${SETENVFL} rssi_report_ip $Y1 > /dev/null
    ${SETENVFL} rssi_report_port $Y2 > /dev/null
    ${SETENVFL} rssi_report_period $Y3 > /dev/null

    echo "Done."
fi








