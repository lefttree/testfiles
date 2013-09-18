#!/bin/sh
echo "Content-type: text/html"
echo ""

APIREAD=/usr/local/cgi-bin/api_read.sh
NodeId=`${APIREAD} nodeid`
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
echo '<script language="javascript" type="text/javascript" src="lib/spin.js"></script>'
echo '</head>'
#
#javascript
#
echo "<script>"
#spinner setup
echo "var spinner_opts = {"
echo "   lines: 13, // The number of lines to draw"
echo "   length: 50, // The length of each line"
echo "   width: 10, // The line thickness"
echo "   radius: 30, // The radius of the inner circle"
echo "   rotate: 0, // The rotation offset"
echo "   color: '#416D9C', // #rgb or #rrggbb"
echo "   speed: 1, // Rounds per second"
echo "   trail: 60, // Afterglow percentage"
echo "   shadow: false, // Whether to render a shadow"
echo "   hwaccel: false, // Whether to use hardware acceleration"
echo "   className: 'spinner', // The CSS class to assign to the spinner"
echo "   zIndex: 2e9, // The z-index (defaults to 2000000000)"
echo "   top: 'auto', // Top position relative to parent in px"
echo "   left: 'auto' // Left position relative to parent in px"
echo "};"
echo "var spinner = new Spinner(spinner_opts);"
#get local node ip
echo "function idToIP(id) {"
echo "    // get ip address of selected radio"
echo "    var ip = '172.20.';"
echo "    var msb = Math.floor((parseInt(id)/256));"
echo "    var lsb = parseInt(id) - msb * 256;"
echo "    ip = ip + msb.toString() + '.' + lsb.toString();"
echo "    return ip;"
echo "}"
echo "function uploadFirmware(){"
echo "	var oData = new FormData(document.forms.namedItem('firmware_upload_form'));"
echo "	var flist = document.getElementById('firmware_file').files;"
echo "	var reader = new FileReader();"
echo "	var ip = idToIP(${NodeId});"
echo "	reader.addEventListener('loadend', function(){"
echo "	var oReq = new XMLHttpRequest();"
echo "	oReq.onloadend = function(oEvent){"
echo "	  if (oReq.status == 200){"
echo "		console.log('Uploaded!');"
echo "		if(oReq.responseText.indexOf('Done') == -1){"
echo "			alert('Could not upgrade, error status: ' + oReq.responseText);"
echo "		}else{"
echo "			alert('Node upgraded successfully !');"
echo "		}"
echo "	  }else{"
echo "		alert('Could not upload firmware to node, check the connection.');"
echo "		console.log('Error ' + oReq.status + ' occurred uploading your file');"
echo "	  }"
echo "	  spinner.stop();"
echo "	};"
echo "	oReq.open('POST', '/cgi-bin/upload_remote.sh?what=firmware&ip=' + ip, true);"
echo "	oReq.send(oData);"
echo "  });"
echo "	reader.readAsBinaryString(flist[0]);"
echo "  var target = document.getElementById('firmware_upload_form');"
echo "	spinner.spin(target);"
echo "}"
echo "</script>"

echo '<body>'
echo ''
echo '<h2>Build Information</h2>'
echo "<form name="buildInfo" action=\"${SCRIPT}\" method=GET>"
echo '<table>'

build_date=`cat /usr/local/cgi-bin/build_time_stamp`
rf_board=`cat /dev/shm/radio/rfboard | grep RF`
phy_ts=`/usr/local/bin/mconfig phy_revision`
kernel=`uname -a`
version=`sh /usr/local/bin/get_uboot_version.sh`
build_tag=`cat /usr/local/cgi-bin/build_tag`

echo "<tr><td><b>RF Board:</b></td><td> $rf_board </td></tr>"
echo "<tr><td><b>Build Timestamp:</b></td><td> $build_date </td></tr>"
echo "<tr><td><b>Build Tag:</b></td><td> $build_tag </td></tr>"
echo "<tr><td><b>PHY Bitfile Revision:</b></td><td> $phy_ts </td></tr>"
echo "<tr><td><b>Kernel Image:</b></td><td> $kernel </td></tr>"
echo "<tr><td><b>U-boot Version:</b></td><td> $version </td></tr>" 
echo '<tr><td><input type="submit" name="restore" value="Restore Factory Default and Reboot"></td><td>After click, please wait for the restore process to complete</td>'
echo '</tr>'
echo '</table>'

echo '</form>'
#
#upload firmware
#
echo '<br>'
echo '<b>Firmware Upgrade</b>'
echo '<form name="firmware_upload_form" id="firmware_upload_form" enctype="multipart/form-data" method="post" >'
echo 'Firmware Image: <input id="firmware_file" type="file" name="firmware_file" required/>'
echo '</form>'
echo "<form action=\"${SCRIPT}\" method='GET'>"
echo '<table><tr><td>'
echo '<button type="button" onclick=uploadFirmware()>Upload Firmware</button></td>'
echo '<td>'
echo '<input type="submit" name="reboot" value="Reboot"</td></tr>'
echo '</table>'
echo '</form>'
echo '</body>'
echo '</html>'

restore=`echo "$QUERY_STRING" | sed -n 's/^.*restore=\([^&]*\).*$/\1/p'`
reboot=`echo "$QUERY_STRING" | sed -n 's/^.*reboot=\([^&]*\).*$/\1/p'`

if [ "$restore" == "Restore+Factory+Default+and+Reboot" ]; then	
	/usr/local/bin/uboot_transfer.sh "/usr/local/cgi-bin/default_para" "restore" > /dev/null 2>&1 
        /usr/local/bin/setenvlinsingle silent > /dev/null 2>&1 ### to restore console
	/usr/local/cgi-bin/clearMapCache.sh > /dev/null 2>&1   
	/usr/local/cgi-bin/clear_node_label_flash.sh > /dev/null 2>&1  
	echo "Restore Factory Default Done. Now Rebooting ..."
	/sbin/reboot
fi

if [ "$reboot" == "Reboot" ]; then
	/sbin/reboot
fi
