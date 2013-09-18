#!/bin/sh
echo "Content-type: text/html"
echo ""
MCONFIG=/usr/local/bin/mconfig
RELOAD=/etc/rcS.d/S30mwlan
SETENVFL=/usr/local/bin/setenvlinsingle
APICALL=/usr/local/cgi-bin/api_call.sh
APIREAD=/usr/local/cgi-bin/api_read.sh

board_type=`/usr/local/bin/mconfig board_type`
bandwidth=`echo "$QUERY_STRING" | sed -n 's/^.*bandwidth=\([^&]*\).*$/\1/p'` 
if [ "$bandwidth" != "" ]; then
    echo ""
else 
    bandwidth=`${APIREAD} bw`
fi
BW0='';BW1='';
case ${bandwidth} in 
    5)
        BW0='selected'
        ;;
    20)
        BW1='selected'
        ;;
    *)
        ;;
esac 

POWER_MW0='';POWER_MW1='';POWER_MW2='';
power_mw=`echo "$QUERY_STRING" | sed -n 's/^.*power_mw=\([^&]*\).*$/\1/p'`
if [ "$power_mw" != "" ]; then
    echo ""
else 
    power_mw=`${APIREAD} power_mw`
fi

GATEWAY_DISABLE0='';GATEWAY_DISABLE1='';
gateway_disable=`echo "$QUERY_STRING" | sed -n 's/^.*gateway_disable=\([^&]*\).*$/\1/p'`
if [ "$gateway_disable" != "" ]; then
    echo ""
else 
    gateway_disable=`${APIREAD} wbg_disable`
fi

case ${power_mw} in 
    1)
	POWER_MW0='selected'
	;;
    10)
	POWER_MW1='selected'
	;;
    16)
	POWER_MW2='selected'
	;;
    63)
	POWER_MW3='selected'
	;;
    100)
	POWER_MW4='selected'
	;;
    126)
	POWER_MW5='selected'
	;;
    158)
	POWER_MW6='selected'
	;;
    200)
	POWER_MW7='selected'
	;;
    250)
	POWER_MW8='selected'
	;;
    316)
	POWER_MW9='selected'
	;;
    398)
	POWER_MW10='selected'
	;;
    500)
	POWER_MW11='selected'
	;;
    630)
	POWER_MW12='selected'
	;;
    800)
	POWER_MW13='selected'
	;;
    1000)
	POWER_MW14='selected'
	;;
    *)
        ;;
esac

case ${gateway_disable} in 
    0)
	GATEWAY_DISABLE0='selected'
	;;
    1)
	GATEWAY_DISABLE1='selected'
	;;
    *)
        ;;
esac
	
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

freq=`echo "$QUERY_STRING" | sed -n 's/^.*freq=\([^&]*\).*$/\1/p'`
if [ "$freq" != "" ]; then
    echo ""
else 
    freq=`${APIREAD} freq`
fi
supported_freq=`${APIREAD} supported_frequencies`

echo ''
echo '<h2>Basic Configuration <a href='user_manual.pdf#page=15' target='_blank'><font size='2'>(?)</font></a></h2>'
echo "<form name='form0' action=\"${SCRIPT}\" method=GET>"
echo '<table>'
echo "<tr><td colspan='1'>Frequency (MHz) </td><td> <select name='freq' >"

IFS='
'
for key in $supported_freq
do
	if [ "$key" == "$freq" ]; then
		is_selected="selected"
	else
		is_selected=""
	fi
	
	echo "<option value=$key $is_selected>$key</option>"
done

echo "</select></tr>"

echo "<tr><td colspan='1'>Bandwidth</td><td> <select name='bandwidth' >\
      <option value='5'  ${BW0}> 5 MHz\
      <option value='20' ${BW1}> 20 MHz\
      </select></tr>"

echo '<tr>'
echo '  <td><input type="submit" name="checkpage0" value="Apply"></td>'
echo '  <td><input type="submit" name="checkpage0" value="Save and Apply"></td>'
echo '</tr>'
echo '</table>'
echo '</form>'
echo '<hr>'

echo "<form name='form1' action=\"${SCRIPT}\" method=GET>"
echo '<table>'

echo "<tr><td colspan='1'>Transmit Power</td><td> <select name='power_mw' >\
      <option value='1'    ${POWER_MW0}  >    0 dBm /   1 mW\
      <option value='10'   ${POWER_MW1}  >   10 dBm /  10 mW\
      <option value='16'   ${POWER_MW2}  >   12 dBm /  16 mW\
      <option value='63'   ${POWER_MW3}  >   18 dBm /  63 mW\
      <option value='100'  ${POWER_MW4}  >   20 dBm / 100 mW\
      <option value='126'  ${POWER_MW5}  >   21 dBm / 126 mW\
      <option value='158'  ${POWER_MW6}  >   22 dBm / 158 mW\
      <option value='200'  ${POWER_MW7}  >   23 dBm / 200 mW\
      <option value='250'  ${POWER_MW8}  >   24 dBm / 250 mW\
      <option value='316'  ${POWER_MW9}  >   25 dBm / 316 mW\
      <option value='398'  ${POWER_MW10} >   26 dBm / 398 mW\
      <option value='500'  ${POWER_MW11} >   27 dBm / 500 mW\
      <option value='630'  ${POWER_MW12} >   28 dBm / 630 mW\
      <option value='800'  ${POWER_MW13} >   29 dBm / 800 mW\
      <option value='1000' ${POWER_MW14} >   30 dBm /1000 mW\
      </select></tr>"

echo '<tr>'
echo '  <td><input type="submit" name="checkpage1" value="Apply"></td>'
echo '  <td><input type="submit" name="checkpage1" value="Save and Apply"></td>'
echo '</tr>'
echo '</table>'

###for gateway_disable
echo '<hr>'

echo "<form name='form2' action=\"${SCRIPT}\" method=GET>"
echo '<table>'

echo "<tr><td colspan='1'>Gateway </td><td> <select name='gateway_disable' >\
      <option value='0'    ${GATEWAY_DISABLE0}  >    Enable\
      <option value='1'    ${GATEWAY_DISABLE1}  >    Disable\
      </select></tr>"

echo '<tr>'
echo '  <td><input type="submit" name="checkpage2" value="Apply"></td>'
echo '  <td><input type="submit" name="checkpage2" value="Save and Apply"></td>'
echo '</tr>'
echo '</table>'

##gateway_disable

echo '<hr>'

echo "<form name='form3' action=\"${SCRIPT}\" method=GET>"
echo '<input type="submit" name="checkpage3" value="Reboot">'
echo '</form>'

echo '</body>'
echo '</html>'


if [ "$REQUEST_METHOD" != "GET" ]; then
    echo "<hr>Script Error:"\
     "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
     "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
    exit 1
fi

X=`echo "$QUERY_STRING" | sed -n 's/^.*checkpage1=\([^&]*\).*$/\1/p'`
Y=`echo "$QUERY_STRING" | sed -n 's/^.*power_mw=\([^&]*\).*$/\1/p'`
X0=`echo "$QUERY_STRING" | sed -n 's/^.*checkpage0=\([^&]*\).*$/\1/p'`
X2=`echo "$QUERY_STRING" | sed -n 's/^.*checkpage3=\([^&]*\).*$/\1/p'`
Y0=`echo "$QUERY_STRING" | sed -n 's/^.*freq=\([^&]*\).*$/\1/p'`
Y1=`echo "$QUERY_STRING" | sed -n 's/^.*bandwidth=\([^&]*\).*$/\1/p'`
#Y2=`echo "$QUERY_STRING" | sed -n 's/^.*mobility=\([^&]*\).*$/\1/p'`


Z=`echo "$QUERY_STRING" | sed -n 's/^.*checkpage2=\([^&]*\).*$/\1/p'`
Z0=`echo "$QUERY_STRING" | sed -n 's/^.*gateway_disable=\([^&]*\).*$/\1/p'`



if [ "$X2" == "Reboot" ]; then
    echo '<h2>Now rebooting ....</h2>'
    /sbin/reboot
    echo "Done."
fi

if [ "$X" == "Apply" ]; then
    ${APICALL} power_mw $Y > /dev/null
elif [ "$X" == "Save+and+Apply" ]; then
    ${APICALL} power_mw $Y > /dev/null
    echo "Saving into flash ... "
    ${SETENVFL} power_mw $Y > /dev/null
    echo "Done." 
fi



if [ "$X0" == "Apply" ]; then
    echo ""
    ${APICALL} freq_bw "$Y0\",\"$Y1"
    #echo $Y2 > /dev/shm/radio/mobility
    #${RELOAD} > /dev/null 2>&1 /dev/null
    echo "Done."
elif [ "$X0" == "Save+and+Apply" ] ; then
    echo ""
    echo "Saving into flash ... "
    ${SETENVFL} freq $Y0 > /dev/null
    ${SETENVFL} bw $Y1 > /dev/null
    #${SETENVFL} mobility $Y2 > /dev/null
    ${APICALL} freq_bw "$Y0\",\"$Y1"
    #echo $Y2 > /dev/shm/radio/mobility
    #${RELOAD} > /dev/null 2>&1 /dev/null
    echo "Done."
fi



if [ "$Z" == "Apply" ]; then
    ${APICALL} wbg_disable $Z0 > /dev/null
    echo "Done."
elif [ "$Z" == "Save+and+Apply" ]; then
    ${APICALL} wbg_disable $Z0 > /dev/null
    echo "Saving into flash ... "
    ${SETENVFL} gateway_disable $Z0 > /dev/null
    echo "Done." 
fi



