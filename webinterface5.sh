#!/bin/sh
echo "Content-type: text/html"
echo ""

SETENVFL=/usr/local/bin/setenvlinsingle
SERIAL_PORT=54321
APICALL=/usr/local/cgi-bin/api_call.sh
APIREAD=/usr/local/cgi-bin/api_read.sh

serial_mode=`echo "$QUERY_STRING" | sed -n 's/^.*serial_mode=\([^&]*\).*$/\1/p'`
if [ "$serial_mode" != "" ]; then
    echo ""
else 
    serial_mode=`cat /dev/shm/radio/serial_mode`
fi
SERIAL_MODE_DEBUG='';SERIAL_MODE_GPS='';SERIAL_MODE_SOCAT='';SERIAL_MODE_DISABLE=''
case ${serial_mode} in
    'debug')
	SERIAL_MODE_DEBUG="selected"
	;;
    'gps')
	SERIAL_MODE_GPS="selected"
	;;
    'socat')
	SERIAL_MODE_SOCAT="selected"
	;;
    'disable')
	SERIAL_MODE_DISABLE="selected"
	;;
    *)
	;;
esac

test_str=`echo "$QUERY_STRING" | sed -n 's/^.*baud_rate=\([^&]*\).*$/\1/p'`
if [ "$test_str" != "" ]; then
    echo ""
    baud_rate=`echo "$QUERY_STRING" | sed -n 's/^.*baud_rate=\([^&]*\).*$/\1/p'`
    char_size=`echo "$QUERY_STRING" | sed -n 's/^.*char_size=\([^&]*\).*$/\1/p'`
    parity=`echo "$QUERY_STRING" | sed -n 's/^.*parity=\([^&]*\).*$/\1/p'`
    stop_bits=`echo "$QUERY_STRING" | sed -n 's/^.*stop_bits=\([^&]*\).*$/\1/p'`
    hw_flow_control=`echo "$QUERY_STRING" | sed -n 's/^.*hw_flow_control=\([^&]*\).*$/\1/p'`
    sw_flow_control=`echo "$QUERY_STRING" | sed -n 's/^.*sw_flow_control=\([^&]*\).*$/\1/p'`
    serial_ip=`echo "$QUERY_STRING" | sed -n 's/^.*serial_ip=\([^&]*\).*$/\1/p'`
    proto=`echo "$QUERY_STRING" | sed -n 's/^.*proto=\([^&]*\).*$/\1/p'`
    SERIAL_PORT=`echo "$QUERY_STRING" | sed -n 's/^.*serial_port=\([^&]*\).*$/\1/p'`
else 
    serial_config_str=`${APIREAD} serial_config`
    #### parse serial parameters baudrate_bits(5/6/7/8)_parity(N/E)_stopbits(1/2)_hwflow(0/1)_swflow(0/1)_ip_port
    baud_rate=`echo $serial_config_str | cut -d"_" -f1`
    char_size=`echo $serial_config_str | cut -d"_" -f2`
    parity=`echo $serial_config_str | cut -d"_" -f3`
    stop_bits=`echo $serial_config_str | cut -d"_" -f4`
    hw_flow_control=`echo $serial_config_str | cut -d"_" -f5`
    sw_flow_control=`echo $serial_config_str | cut -d"_" -f6`
    serial_ip=`echo $serial_config_str | cut -d"_" -f7`
    proto=`echo $serial_config_str | cut -d"_" -f8`
    SERIAL_PORT=`echo $serial_config_str | cut -d"_" -f9`
fi


BAUD_RATE_9600='';BAUD_RATE_38400='';BAUD_RATE_115200='';
case ${baud_rate} in
    '2400')
	BAUD_RATE_2400="selected"
	;;
    '4800')
	BAUD_RATE_4800="selected"
	;;
    '9600')
	BAUD_RATE_9600="selected"
	;;
    '19200')
	BAUD_RATE_19200="selected"
	;;
    '38400')
	BAUD_RATE_38400="selected"
	;;
    '57600')
	BAUD_RATE_57600="selected"
	;;
    '115200')
	BAUD_RATE_115200="selected"
	;;
    *)
	;;
esac

CHAR_SIZE_5='';CHAR_SIZE_6='';CHAR_SIZE_7='';CHAR_SIZE_8='';
case ${char_size} in
    '5')
	CHAR_SIZE_5="selected"
	;;
    '6')
	CHAR_SIZE_6="selected"
	;;
    '7')
	CHAR_SIZE_7="selected"
	;;
    '8')
	CHAR_SIZE_8="selected"
	;;
    *)
	;;
esac

PARITY_ODD='';PARITY_EVEN='';PARITY_NONE=''
case ${parity} in
    '1')
	PARITY_ODD="selected"
	;;
    '0')
	PARITY_EVEN="selected"
	;;
    '2')
	PARITY_NONE="selected"
	;;
    *)
	;;
esac

STOP_BITS_1='';STOP_BITS_2='';
case ${stop_bits} in
    '0')
	STOP_BITS_1="selected"
	;;
    '1')
	STOP_BITS_2="selected"
	;;
    *)
	;;
esac

SW_FLOW_CONTROL_ENABLED='';SW_FLOW_CONTROL_DISABLED='';
case ${sw_flow_control} in
    '1')
	SW_FLOW_CONTROL_ENABLED="selected"
	;;
    '0')
	SW_FLOW_CONTROL_DISABLED="selected"
	;;
    *)
	;;
esac

HW_FLOW_CONTROL_ENABLED='';HW_FLOW_CONTROL_DISABLED='';
case ${hw_flow_control} in
    '1')
	HW_FLOW_CONTROL_ENABLED="selected"
	;;
    '0')
	HW_FLOW_CONTROL_DISABLED="selected"
	;;
    *)
	;;
esac

PROTO_TCP='';PROTO_UDP='';
case ${proto} in
    'tcp')
	PROTO_TCP="selected"
	;;
    'udp')
	PROTO_UDP="selected"
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

echo '<body>'

echo ''
echo '<h2>Serial Port Setup <a href='user_manual.pdf#page=23' target='_blank'><font size='2'>(?)</font></a></h2>'
echo "<form name='serialPort' action=\"${SCRIPT}\" method=GET>"
echo '<table>'

echo "<tr><td>Serial Port Mode</td><td> <select name='serial_mode' >\
      <option value='gps' ${SERIAL_MODE_GPS}> GPS\
      <option value='socat' ${SERIAL_MODE_SOCAT}> RS-232\
      <option value='debug' ${SERIAL_MODE_DEBUG}> Console\
      <option value='disable' ${SERIAL_MODE_DISABLE}> Disabled\
      </select></tr>"
echo '<tr><td><input type="submit" name="mode_change" value="Save and Reboot"></td><td></td></tr>'
echo '</table>'

echo '<hr>'

echo '<b>Serial Port Settings (Only for RS-232 Mode)</b>'
echo '<table>'
echo "<tr><td>Baud Rate</td><td> <select name='baud_rate' >\
      <option value='2400' ${BAUD_RATE_2400}> 2400\
      <option value='4800' ${BAUD_RATE_4800}> 4800\
      <option value='9600' ${BAUD_RATE_9600}> 9600\
      <option value='19200' ${BAUD_RATE_19200}> 19200\
      <option value='38400' ${BAUD_RATE_38400}> 38400\
      <option value='57600' ${BAUD_RATE_57600}> 57600\
      <option value='115200' ${BAUD_RATE_115200}> 115200\
      </select></tr>"
echo "<tr><td>Data Bits</td><td> <select name='char_size' >\
      <option value='5' ${CHAR_SIZE_5}> 5\
      <option value='6' ${CHAR_SIZE_6}> 6\
      <option value='7' ${CHAR_SIZE_7}> 7\
      <option value='8' ${CHAR_SIZE_8}> 8\
      </select></tr>"
echo "<tr><td>Parity</td><td> <select name='parity' >\
      <option value='1' ${PARITY_ODD}> Odd(O)\
      <option value='0' ${PARITY_EVEN}> Even(E)\
      <option value='2' ${PARITY_NONE}> None(N)\
      </select></tr>"
echo "<tr><td>Stop Bits</td><td> <select name='stop_bits' >\
      <option value='0' ${STOP_BITS_1}> 1\
      <option value='1' ${STOP_BITS_2}> 2\
      </select></tr>"
echo "<tr><td>Software Flow Control</td><td> <select name='sw_flow_control' >\
      <option value='1' ${SW_FLOW_CONTROL_ENABLED}> Enable\
      <option value='0' ${SW_FLOW_CONTROL_DISABLED}> Disable\
      </select></tr>"
echo "<tr><td>Hardware Flow Control</td><td> <select name='hw_flow_control' >\
      <option value='1' ${HW_FLOW_CONTROL_ENABLED}> Enable\
      <option value='0' ${HW_FLOW_CONTROL_DISABLED}> Disable\
      </select></tr>"
echo "<tr><td>Transport Protocol</td><td> <select name='proto' >\
      <option value='tcp' ${PROTO_TCP}> TCP\
      <option value='udp' ${PROTO_UDP}> UDP\
      </select></tr>"
echo "<tr><td>Peer IP</td><td><input type='text' name='serial_ip' value=${serial_ip}></td></tr>"
echo "<tr><td>Peer Port</td><td><input type='text' name='serial_port' value='${SERIAL_PORT}'></td></tr>"

echo '</table>'

echo '<tr><td><input type="submit" name="advance" value="Apply"></td><td></td></tr>'
echo '<tr><td><input type="submit" name="advance" value="Save and Apply"></td><td></td></tr>'
echo '</table>'

echo '</form>'
echo '</body>'
echo '</html>'

serial_mode=`echo "$QUERY_STRING" | sed -n 's/^.*serial_mode=\([^&]*\).*$/\1/p'`
app=`echo "$QUERY_STRING" | sed -n 's/^.*advance=\([^&]*\).*$/\1/p'`
app1=`echo "$QUERY_STRING" | sed -n 's/^.*mode_change=\([^&]*\).*$/\1/p'`
baud_rate=`echo "$QUERY_STRING" | sed -n 's/^.*baud_rate=\([^&]*\).*$/\1/p'`
char_size=`echo "$QUERY_STRING" | sed -n 's/^.*char_size=\([^&]*\).*$/\1/p'`
parity=`echo "$QUERY_STRING" | sed -n 's/^.*parity=\([^&]*\).*$/\1/p'`
stop_bits=`echo "$QUERY_STRING" | sed -n 's/^.*stop_bits=\([^&]*\).*$/\1/p'`
hw_flow_control=`echo "$QUERY_STRING" | sed -n 's/^.*hw_flow_control=\([^&]*\).*$/\1/p'`
sw_flow_control=`echo "$QUERY_STRING" | sed -n 's/^.*sw_flow_control=\([^&]*\).*$/\1/p'`
serial_ip=`echo "$QUERY_STRING" | sed -n 's/^.*serial_ip=\([^&]*\).*$/\1/p'`
proto=`echo "$QUERY_STRING" | sed -n 's/^.*proto=\([^&]*\).*$/\1/p'`
SERIAL_PORT=`echo "$QUERY_STRING" | sed -n 's/^.*serial_port=\([^&]*\).*$/\1/p'`

if [ "$app1" == "Save+and+Reboot" ]; then
    echo "Saving into flash ..."
    ${SETENVFL} serial_mode $serial_mode > /dev/null

    case ${serial_mode} in
	'debug')
	    ${SETENVFL} silent > /dev/null
	    ;;
	'gps')
	    ${SETENVFL} silent 1 > /dev/null
	    ;;
	'socat')
	    ${SETENVFL} silent 1 > /dev/null
	    ;;
	'disable')
	    ${SETENVFL} silent 1 > /dev/null
	    ;;
	*)
	    ;;
    esac
    echo "Done. Rebooting ..."
    /sbin/reboot
fi

if [ "$app" == "Save+and+Apply" ]; then
    serial_config_str="${baud_rate}_${char_size}_${parity}_${stop_bits}_${hw_flow_control}_${sw_flow_control}_${serial_ip}_${proto}_${SERIAL_PORT}"
    serial_config_str_t="${baud_rate}\",\"${char_size}\",\"${parity}\",\"${stop_bits}\",\"${hw_flow_control}\",\"${sw_flow_control}\",\"${serial_ip}\",\"${proto}\",\"${SERIAL_PORT}"
    ${APICALL} serial_config $serial_config_str_t
    ${SETENVFL} serial_config_str $serial_config_str > /dev/null
    echo "Done."
elif [ "$app" == "Apply" ]; then
    serial_config_str="${baud_rate}\",\"${char_size}\",\"${parity}\",\"${stop_bits}\",\"${hw_flow_control}\",\"${sw_flow_control}\",\"${serial_ip}\",\"${proto}\",\"${SERIAL_PORT}"
    ${APICALL} serial_config $serial_config_str
    echo "Done."
fi 
