#!/bin/sh
echo "Content-type: text/html"
echo ""
MCONFIG=/usr/local/bin/mconfig
RELOAD=/etc/rcS.d/S30mwlan
SETENVFL=/usr/local/bin/setenvlinsingle
APICALL=/usr/local/cgi-bin/api_call.sh
APIREAD=/usr/local/cgi-bin/api_read.sh

link_distance=`echo "$QUERY_STRING" | sed -n 's/^.*link_distance=\([^&]*\).*$/\1/p'`
if [ "$link_distance" != "" ]; then
    echo ""
else 
    link_distance=`${APIREAD} max_link_distance`
fi

enc_disable=`echo "$QUERY_STRING" | sed -n 's/^.*enc_disable=\([^&]*\).*$/\1/p'`
if [ "$enc_disable" != "" ]; then
    echo ""
else 
    enc_disable=`${APIREAD} enc_disable`
fi
ENC_DISABLE0='';ENC_DISABLE1='';
case ${enc_disable} in 
    0)
        ENC_DISABLE0="selected"
	key_disabled=0
        ;;
    1)
        ENC_DISABLE1="selected"
	key_disabled=1
        ;;
    *)
        ;;
esac 

enc_key_len=`echo "$QUERY_STRING" | sed -n 's/^.*enc_key_len=\([^&]*\).*$/\1/p'`
if [ "$enc_key_len" != "" ]; then
    echo ""
else 
    enc_key_len=`${APIREAD} enc_key_len`
fi
ENC_KEY_LEN128='';ENC_KEY_LEN256='';
case ${enc_key_len} in 
    128)
        ENC_KEY_LEN128="selected"
        ;;
    256)
        ENC_KEY_LEN256="selected"
        ;;
    *)
        ;;
esac 

aggr_thresh=`echo "$QUERY_STRING" | sed -n 's/^.*aggr_thresh=\([^&]*\).*$/\1/p'`
if [ "$aggr_thresh" != "" ]; then
    echo ""
else 
    aggr_thresh=`${APIREAD} aggr_thresh`
fi
AGGR_THRESH1600='';AGGR_THRESH800='';AGGR_THRESH400='';AGGR_THRESH200='';
case ${aggr_thresh} in 
    1600)
        AGGR_THRESH1600="selected"
        ;;
    800)
        AGGR_THRESH800="selected"
        ;;
    400)
        AGGR_THRESH400="selected"
        ;;
    200)
        AGGR_THRESH200="selected"
        ;;
    *)
        ;;
esac 

##############################
rts_disable=`echo "$QUERY_STRING" | sed -n 's/^.*rts_disable=\([^&]*\).*$/\1/p'`
if [ "$rts_disable" != "" ]; then
    echo ""
else 
    rts_disable=`${APIREAD} rts_disable`
fi
RTS_DISABLE0='';RTS_DISABLE1='';
case ${rts_disable} in 
    0)
        RTS_DISABLE0="selected"
        ;;
    1)
        RTS_DISABLE1="selected"
        ;;
    *)
        ;;
esac 
##############################
max_speed=`echo "$QUERY_STRING" | sed -n 's/^.*max_speed=\([^&]*\).*$/\1/p'`
if [ "$max_speed" != "" ]; then
    echo ""
else 
    max_speed=`${APIREAD} max_speed`
fi
case ${max_speed} in
    0)
	MAX_SPEED0='selected'
	;;
    2) 
	MAX_SPEED2='selected'
	;;
    10) 
	MAX_SPEED10='selected'
	;;
    20) 
	MAX_SPEED20='selected'
	;;
    40) 
	MAX_SPEED40='selected'
	;;
    70) 
	MAX_SPEED70='selected'
	;;
esac
#########################

##burst_time init
burst_time=`echo "$QUERY_STRING" | sed -n 's/^.*burst_time=\([^&]*\).*$/\1/p'`
if [ "$burst_time" != "" ]; then
    echo ""
else 
    burst_time=`${APIREAD} burst_time`
fi
case ${burst_time} in
	2000)
		BURST_TIME02='selected'
		;;
	10000)
		BURST_TIME10='selected'
		;;
	20000)
		BURST_TIME20='selected'
		;;
	30000)
		BURST_TIME30='selected'
		;;
	40000)
		BURST_TIME40='selected'
		;;
	50000)
		BURST_TIME50='selected'
		;;
	60000)
		BURST_TIME60='selected'
		;;
	70000)
		BURST_TIME70='selected'
		;;
	80000)
		BURST_TIME80='selected'
		;;
	90000)
		BURST_TIME90='selected'
		;;
	100000)
		BURST_TIME100='selected'
		;;
esac

enc_key="`echo "$QUERY_STRING" | sed -n 's/^.*enc_key=\([^&]*\).*$/\1/p'`"
if [ "$enc_key" != "" ]; then
    echo ""
else 
    enc_key="`${APIREAD} enc_key`"
fi

phy=`echo "$QUERY_STRING" | sed -n 's/^.*phytest=\([^&]*\).*$/\1/p'`
if [ "$phy" != "" ]; then
    echo ""
else 
    phy=`${APIREAD} radio_mode`
fi
PHY0='';PHY1='';
case ${phy} in
    0)
	PHY0='selected'
	;;
    1) 
	PHY1='selected'
	;;
    2) 
	PHY2='selected'
	;;
    3) 
	PHY3='selected'
	;;
esac
###########################################
## CLASS0_MCS init
class0_mcs=`echo "$QUERY_STRING" | sed -n 's/^.*class0_mcs=\([^&]*\).*$/\1/p'`
if [ "$class0_mcs" != "" ]; then
    echo ""
else 
    class0_mcs=`${APIREAD} mcs`
fi

CLASS0_MCSA='';CLASS0_MCS0='';CLASS0_MCS1='';CLASS0_MCS2='';CLASS0_MCS3='';CLASS0_MCS4='';CLASS0_MCS8='';CLASS0_MCS9='';CLASS0_MCS10='';CLASS0_MCS11='';CLASS0_MCS12='';CLASS0_MCS16='';CLASS0_MCS17='';CLASS0_MCS18='';CLASS0_MCS19='';CLASS0_MCS20='';CLASS0_MCS24='';CLASS0_MCS25='';CLASS0_MCS26='';CLASS0_MCS27='';CLASS0_MCS28='';
#echo ${mc}
case ${class0_mcs} in
    255)
        CLASS0_MCSA='selected'
        ;; 
    0)
        CLASS0_MCS0='selected'
        ;;
    1)
        CLASS0_MCS1='selected'
        ;;
    2)
        CLASS0_MCS2='selected'
        ;;
    3)
        CLASS0_MCS3='selected'
        ;;
    4)
        CLASS0_MCS4='selected'
        ;;
    8)
        CLASS0_MCS8='selected'
        ;;
    9)
        CLASS0_MCS9='selected'
        ;;
    10)
        CLASS0_MCS10='selected'
        ;;
    11)
	CLASS0_MCS11='selected'
	;;
    12)
	CLASS0_MCS12='selected'
	;;
    16)
	CLASS0_MCS16='selected'
	;;
    17)
	CLASS0_MCS17='selected'
	;;
    18)
	CLASS0_MCS18='selected'
	;;
    19)
	CLASS0_MCS19='selected'
	;;
    20)
	CLASS0_MCS20='selected'
	;;
    24)
	CLASS0_MCS24='selected'
	;;
    25)
	CLASS0_MCS25='selected'
	;;
    26)
	CLASS0_MCS26='selected'
	;;
    27)
	CLASS0_MCS27='selected'
	;;
    28)
	CLASS0_MCS28='selected'
	;;

    *)
	;;
esac 
###############################################
## virtual IP init
vir_ip_disable=`echo "$QUERY_STRING" | sed -n 's/^.*vir_ip_disable=\([^&]*\).*$/\1/p'`
if [ "$vir_ip_disable" != "" ]; then
    echo ""
else 
    vir_ip_disable=`${APIREAD} virtual_ip_disable`
fi
VIR_IP_DISABLE0='';VIR_IP_DISABLE1='';
case ${vir_ip_disable} in 
    0)
        VIR_IP_DISABLE0="selected"
        ;;
    1)
        VIR_IP_DISABLE1="selected"
        ;;
    *)
        ;;
esac 



vir_addr="`echo "$QUERY_STRING" | sed -n 's/^.*vir_addr=\([^&]*\).*$/\1/p'`"
if [ "$vir_addr" != "" ]; then
    echo ""
else
    vir_addr=`${APIREAD} virtual_ip_address`
fi

vir_netmask=`echo "$QUERY_STRING" | sed -n 's/^.*vir_netmask=\([^&]*\).*$/\1/p'`
if [ "$vir_netmask" != "" ] ; then
    echo ""
else 
    vir_netmask=`${APIREAD} virtual_ip_netmask`
fi


vir_gw=`echo "$QUERY_STRING" | sed -n 's/^.*vir_gw=\([^&]*\).*$/\1/p'`
if [ "$vir_gw" != "" ] ; then
    echo ""
else 
    vir_gw=`${APIREAD} virtual_ip_gateway`
fi


vpn_addr=`echo "$QUERY_STRING" | sed -n 's/^.*vpn_addr=\([^&]*\).*$/\1/p'`
if [ "$vpn_addr" != "" ] ; then
    echo ""
else 
    p=`${APIREAD} vpn_address`
    var=$(echo $p | awk -F"_" '{print $1,$2}')
    set -- $var
    vpn_addr=$1
fi

vpn_port=`echo "$QUERY_STRING" | sed -n 's/^.*vpn_port=\([^&]*\).*$/\1/p'`
if [ "$vpn_port" != "" ] ; then
    echo ""
else 
    p=`${APIREAD} vpn_address`
    var=$(echo $p | awk -F"_" '{print $1,$2}')
    set -- $var
    vpn_port=$2
fi



vpn_disable=`echo "$QUERY_STRING" | sed -n 's/^.*vpn_disable=\([^&]*\).*$/\1/p'`
if [ "$vpn_disable" != "" ]; then
    echo ""
else 
    vpn_disable=`${APIREAD} vpn_disable`
fi
VPN_DISABLE0='';VPN_DISABLE1='';
case ${vpn_disable} in 
    0)
        VPN_DISABLE0="selected"
        ;;
    1)
        VPN_DISABLE1="selected"
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

echo '<script type = "text/javascript"> '
echo "function enc_onload(){"
echo '	var enc = document.getElementById("enc_field"); '
echo "	if (${key_disabled} == 0)"
echo "  	enc.disabled = false ; "
echo "  else"
echo "  	enc.disabled = true ; "
echo "}"
echo 'function enc_change(select){'
echo '  var selectedOption = select.options[select.selectedIndex];'
echo '  var enc = document.getElementById("enc_field");  '
echo '  if (selectedOption.value == 0 ){'
echo '      enc.disabled = false ;  '
echo '  }'
echo '  else{ '
echo '      enc.disabled = true ;  '
echo '  }'
echo '}'
echo '</script>'

echo '<title>Silvus StreamCaster MIMO Radio</title>'
echo '</head>'

echo '<body onload="enc_onload()">'

echo ''
echo '<h2>Advanced Configuration <a href='user_manual.pdf#page=17' target='_blank'><font size='2'>(?)</font></a></h2>'
echo '<h3>MAC Settings: </h3>'

echo "<form name="formADVANCED1" action=\"${SCRIPT}\" method=GET>"
echo '<table>'

echo "<tr><td>Link Distance (m)</td><td><input type='text' name='link_distance' value=${link_distance}></td></tr>"

echo "<tr><td>RTS/CTS</td><td> <select name='rts_disable' >\
      <option value='0' ${RTS_DISABLE0}> Enable\
      <option value='1' ${RTS_DISABLE1}> Disable\
      </select></tr>"
#echo '</table>'

echo "<tr><td>Fragmentation Threshold</td><td> <select name='aggr_thresh'>\
      <option value='1600' ${AGGR_THRESH1600}> 1600 Bytes\
      <option value='800' ${AGGR_THRESH800}> 800 Bytes\
      <option value='400' ${AGGR_THRESH400}> 400 Bytes\
      <option value='200' ${AGGR_THRESH200}> 200 Bytes\
      </select></tr>"

echo "<tr><td>Maximum Ground Speed</td><td> <select name='max_speed'>\
      <option value='0' ${MAX_SPEED0}> 0 mph\
      <option value='2' ${MAX_SPEED2}> 2 mph\
      <option value='10' ${MAX_SPEED10}> 10 mph\
      <option value='20' ${MAX_SPEED20}> 20 mph\
      <option value='40' ${MAX_SPEED40}> 40 mph\
      <option value='70' ${MAX_SPEED70}> 70 mph\
      </select></tr>"

echo "<tr><td>Burst Time</td><td> <select name='burst_time' >\
     <option value='2000'  ${BURST_TIME02}>  2ms</option>
     <option value='10000' ${BURST_TIME10}> 10ms</option>
     <option value='20000' ${BURST_TIME20}> 20ms</option>	
     <option value='30000' ${BURST_TIME30}> 30ms</option>
     <option value='40000' ${BURST_TIME40}> 40ms</option>
     <option value='50000' ${BURST_TIME50}> 50ms</option>
     <option value='60000' ${BURST_TIME60}> 60ms</option>
     <option value='70000' ${BURST_TIME70}> 70ms</option>
     <option value='80000' ${BURST_TIME80}> 80ms</option>
     <option value='90000' ${BURST_TIME90}> 90ms</option>
     <option value='100000' ${BURST_TIME100}> 100ms</option>	
     </select></tr>"

echo "<tr><td>Encryption</td><td> <select name='enc_disable' onchange='enc_change(this)'>\
      <option value='0' ${ENC_DISABLE0}> Enable\
      <option value='1' ${ENC_DISABLE1}> Disable\
      </select></tr>"

echo "<tr><td>Encryption Type</td><td> <select name='enc_key_len' >\
      <option value='128' ${ENC_KEY_LEN128}> 128-bit\
      <option value='256' ${ENC_KEY_LEN256}> 256-bit\
      </select></tr>"

#echo '</table>'

echo "<tr><td>Encryption Key (Aa-zZ,0-9)</td><td><input id ='enc_field' type='password'  name='enc_key' value='${enc_key}'></td></tr>"


#########
#MCS Class 0 (MCP/UCP)
#########
echo "<tr><td colspan='1'>MCS</td><td> <select name='class0_mcs' >\
      <option value='255' ${CLASS0_MCSA}>  Auto            </option>\
      <option value='0'  ${CLASS0_MCS0}>  MCS0:  1 stream </option>\
      <option value='1'  ${CLASS0_MCS1}>  MCS1:  1 stream </option>\
      <option value='2'  ${CLASS0_MCS2}>  MCS2:  1 stream </option>\
      <option value='3'  ${CLASS0_MCS3}>  MCS3:  1 stream </option>\
      <option value='4'  ${CLASS0_MCS4}>  MCS4:  1 stream </option>\
      <option value='8'  ${CLASS0_MCS8}>  MCS8:  2 streams</option>\
      <option value='9'  ${CLASS0_MCS9}>  MCS9:  2 streams</option>\
      <option value='10' ${CLASS0_MCS10}> MCS10: 2 streams</option>\
      <option value='11' ${CLASS0_MCS11}> MCS11: 2 streams</option>\
      <option value='12' ${CLASS0_MCS12}> MCS12: 2 streams</option>\
      <option value='16' ${CLASS0_MCS16}> MCS16: 3 streams</option>\
      <option value='17' ${CLASS0_MCS17}> MCS17: 3 streams</option>\
      <option value='18' ${CLASS0_MCS18}> MCS18: 3 streams</option>\
      <option value='19' ${CLASS0_MCS19}> MCS19: 3 streams</option>\
      <option value='20' ${CLASS0_MCS20}> MCS20: 3 streams</option>\
      <option value='24' ${CLASS0_MCS24}> MCS24: 4 streams</option>\
      <option value='25' ${CLASS0_MCS25}> MCS25: 4 streams</option>\
      <option value='26' ${CLASS0_MCS26}> MCS26: 4 streams</option>\
      <option value='27' ${CLASS0_MCS27}> MCS27: 4 streams</option>\
      <option value='28' ${CLASS0_MCS28}> MCS28: 4 streams</option>\
      </select></tr>"
#echo '</table>'

##########
# phytest
##########
echo "<tr><td colspan='1'>Radio Mode</td><td> <select name='phytest' >\
      <option value=0 ${PHY0}>  Network Mode(0) </option>\
      <option value=1 ${PHY1}>  PHY Diagnostics(1) </option>\
      </select></tr>"
echo '</table>'
echo '<tr><td><input type="submit" name="advance1" value="Apply"></td>'
echo '<td><input type="submit" name="advance1" value="Save and Apply"></td><td></td></tr>'

echo '</table>'
echo '</form>'


##########
# virtual ip
#########
echo '<h3>Network Settings: </h3>'
echo "<form name="formADVANCED2" action=\"${SCRIPT}\" method=GET>"
echo '<table>'

echo "<tr><td>Virtual IP</td><td> <select name='vir_ip_disable' >\
      <option value='0' ${VIR_IP_DISABLE0}> Enable\
      <option value='1' ${VIR_IP_DISABLE1}> Disable\
      </select></tr>"


echo "<tr><td>Virtual IP Address</td><td><input type='text' name='vir_addr' value=${vir_addr}></td></tr>"
echo "<tr><td>Virtual Netmask</td><td><input type='text' name='vir_netmask' value=${vir_netmask}></td></tr>"
echo "<tr><td>Gateway</td><td><input type='text' name='vir_gw' value=${vir_gw}></td></tr>"

echo "<tr><td>VPN</td><td> <select name='vpn_disable' >\
      <option value='0' ${VPN_DISABLE0}> Enable\
      <option value='1' ${VPN_DISABLE1}> Disable\
      </select></tr>"

echo "<tr><td>VPN Server IP</td><td><input type='text' name='vpn_addr' value=${vpn_addr}></td></tr>"
echo "<tr><td>VPN Server Port</td><td><input type='text' name='vpn_port' value=${vpn_port}></td></tr>"

echo '</table>'
echo '<tr><td><input type="submit" name="advance2" value="Apply"></td>'
echo '<td><input type="submit" name="advance2" value="Save and Apply"></td><td></td></tr>'
echo '</table>'

echo '</form>'
echo '</body>'
echo '</html>'
############
if [ "$REQUEST_METHOD" != "GET" ]; then
    echo "<hr>Script Error:"\
     "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
     "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
    exit 1
fi
############
app1=`echo "$QUERY_STRING" | sed -n 's/^.*advance1=\([^&]*\).*$/\1/p'`
app2=`echo "$QUERY_STRING" | sed -n 's/^.*advance2=\([^&]*\).*$/\1/p'`
phy=`echo "$QUERY_STRING" | sed -n 's/^.*phytest=\([^&]*\).*$/\1/p'`
############
class0_mcs=`echo "$QUERY_STRING" | sed -n 's/^.*class0_mcs=\([^&]*\).*$/\1/p'`
link_distance=`echo "$QUERY_STRING" | sed -n 's/^.*link_distance=\([^&]*\).*$/\1/p'`
enc_disable=`echo "$QUERY_STRING" | sed -n 's/^.*enc_disable=\([^&]*\).*$/\1/p'`
enc_key_len=`echo "$QUERY_STRING" | sed -n 's/^.*enc_key_len=\([^&]*\).*$/\1/p'`
aggr_thresh=`echo "$QUERY_STRING" | sed -n 's/^.*aggr_thresh=\([^&]*\).*$/\1/p'`
############ange
rts_disable=`echo "$QUERY_STRING" | sed -n 's/^.*rts_disable=\([^&]*\).*$/\1/p'`
max_speed=`echo "$QUERY_STRING" | sed -n 's/^.*max_speed=\([^&]*\).*$/\1/p'`
burst_time=`echo "$QUERY_STRING" | sed -n 's/^.*burst_time=\([^&]*\).*$/\1/p'`
enc_key="`echo "$QUERY_STRING" | sed -n 's/^.*enc_key=\([^&]*\).*$/\1/p'`"
prephy=`${APIREAD} radio_mode`

######
if [ "$app1" == "Save+and+Apply" ]; then
    if [ $prephy -ne $phy ]; then
	${APICALL} radio_mode $phy			
	${SETENVFL} phytest $phy > /dev/null
    fi


    if [ $class0_mcs -eq 255 ]; then
	${APICALL} mcs $class0_mcs		
	${SETENVFL} ladisable 0 > /dev/null
    else
	${APICALL} mcs $class0_mcs		
	${SETENVFL} ladisable 1 > /dev/null
    fi

    ${SETENVFL} class0_mcs $class0_mcs

    ${SETENVFL} enc_disable $enc_disable > /dev/null
    ${APICALL} enc_disable $enc_disable

    ${SETENVFL} enc_key_len "$enc_key_len" > /dev/null
    ${APICALL} enc_key_len $enc_key_len

    ${SETENVFL} aggr_thresh $aggr_thresh > /dev/null
    ${APICALL} aggr_thresh $aggr_thresh

    ${SETENVFL} rts_disable $rts_disable > /dev/null
    ${APICALL} rts_disable $rts_disable

    ${SETENVFL} enc_key "$enc_key" > /dev/null
    ${APICALL} enc_key $enc_key

    ${APICALL} max_link_distance $link_distance

    echo "Saving into flash ... "
    ${SETENVFL} link_distance $link_distance > /dev/null
    ${APICALL} max_speed $max_speed

    ${SETENVFL} max_speed $max_speed > /dev/null
    ${APICALL} burst_time $burst_time

    ${SETENVFL} burst_time $burst_time > /dev/null

    echo "Done."
elif [ "$app1" == "Apply" ]; then
    if [ $prephy -ne $phy ]; then
        ${APICALL} radio_mode $phy
    fi
    
    ${APICALL} mcs $class0_mcs

    ${APICALL} enc_disable $enc_disable
    ${APICALL} enc_key_len $enc_key_len
    ${APICALL} aggr_thresh $aggr_thresh
    ${APICALL} rts_disable $rts_disable
    ${APICALL} enc_key $enc_key
    ${APICALL} max_link_distance $link_distance
    ${APICALL} max_speed $max_speed
    ${APICALL} burst_time $burst_time

    echo "Done."

fi
######
if [ "$app2" == "Save+and+Apply" ]; then
    ${APICALL} virtual_ip_address "$vir_addr"
    ${APICALL} virtual_ip_netmask "$vir_netmask"
    ${APICALL} virtual_ip_gateway "$vir_gw"
    ${APICALL} virtual_ip_disable "$vir_ip_disable"

    ${SETENVFL} vir_ip_disable "$vir_ip_disable" > /dev/null
    ${SETENVFL} vir_addr "$vir_addr" > /dev/null
    ${SETENVFL} vir_netmask "$vir_netmask" > /dev/null
    ${SETENVFL} vir_gw "$vir_gw" > /dev/null

    ${APICALL} vpn_address "$vpn_addr\",\"$vpn_port" 
    ${APICALL} vpn_disable "$vpn_disable"

    ${SETENVFL} vpn_server_address "$vpn_addr""_""$vpn_port" > /dev/null
    ${SETENVFL} vpn_disable "$vpn_disable" > /dev/null

    /usr/local/bin/setvirtual_ip.sh

    echo "Done."

elif [ "$app2" == "Apply" ]; then


    ${APICALL} virtual_ip_address "$vir_addr"                                         
    ${APICALL} virtual_ip_netmask "$vir_netmask"                                      
    ${APICALL} virtual_ip_gateway "$vir_gw"                                           
    ${APICALL} virtual_ip_disable "$vir_ip_disable"  
    ${APICALL} vpn_address "$vpn_addr\",\"$vpn_port"                                  
    ${APICALL} vpn_disable "$vpn_disable"

    echo "Done."

fi

