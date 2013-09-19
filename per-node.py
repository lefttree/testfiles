#!/usr/bin/python
import subprocess, time
import jsonrpclib
import fileinput
import sys

if __name__ == '__main__':
	args = sys.argv[1].split(" ")
	#args[0] --- radio_ip
	#args[1] --- browser
	#args[2] --- node_id

	#
	#write current time into output file
	#
	f = open('outputfile', 'a')
	f.write("------------------------" + time.asctime() + "------------------------\n")
	f.write("----- Start of Per-Node test -----\n")
	f.close()
	ip = args[0]
	browser = args[1]
	node_id = args[2]
	
	'''
	#
	#test freq select
	#
	frequencies = [2420,2440,2452,2466.666667,2480,2492,4942.5,4947.5,4952.5,4955,4957.5,4960,4962.5,4967.5,4972.5,4975,4977.5,4982.5,4987.5,5120,5745,5765,5785,5805,5825]
	for freqline in frequencies:
		freq = str(freqline)
		print "testing frequency " + freq
		callString = "./net_select.py '" + ip + " " + browser + " Per-Node freq " + freq + " " + node_id + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()
	'''
	#
	#test bw select
	#
	bw_options = ["5", "20"]
	for bw in bw_options:
		print "testing bandwidth " + bw
		callString = "./net_select.py '" + ip + " " + browser + " Per-Node bw " + bw + " " + node_id + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()
	
	#
	#test transmit power
	#
	power_dBm_options = ["0", "10", "12", "18", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]	
	for power_dBm in power_dBm_options:
		print "testing power_dBm " + power_dBm
		callString = "./net_select.py '" + ip + " " + browser + " Per-Node txpower " + power_dBm + " " + node_id + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()
	

	#
	#test link distance
	#
	
	distance_value = ["500"]
	for distance in distance_value:
		print "testing link_distance " + distance
		callString = "./net_textfield.py '" + ip + " " + browser + " Per-Node link_distance " + distance + " " + node_id + "'"
		#callString = "./textfield.py '172.20.4.180 firefox webinterface2.sh link_distance " + str(distance) + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()
	
	#
	#test rts_disable
	#
	rts_cts = ["Enable", "Disable"]
	for E_D in rts_cts:
		print "testing rts_disable " + E_D
		callString = "./net_select.py '" + ip + " " + browser + " Per-Node rts_disable " + E_D + " " + node_id + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()
	#
	#test threshold
	#
	thresholds = ["1600", "800", "400", "200"]
	for threshold in thresholds:
		print "testing fragmentation threshold " + threshold
		callString = "./net_select.py '" + ip + " " + browser + " Per-Node aggr_thresh " + threshold + " " + node_id + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()
	#
	#test max_gound_speed
	#
	max_speeds = ["0", "2", "10", "20", "40", "70"]
	for max_speed in max_speeds:
		print "testing max_ground_speed " + max_speed
		callString = "./net_select.py '" + ip + " " + browser + " Per-Node max_speed " + max_speed + " " + node_id + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()
	#
	#test burst time
	#
	burst_times = ["2", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"]
	for burst_time in burst_times:
		print "testing burst_time " + burst_time
		callString = "./net_select.py '" + ip + " " + browser + " Per-Node burst_time " + burst_time + " " + node_id + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()

	#
	#test 
	#
	mcs_options = ["Auto", "0", "1", "2", "3", "4", "8", "9", "10", "11", "12", "16", "17", "18", "19", "20", "24", "25", "26", "27", "28"]
	for mcs in mcs_options:
		print "testing mcs " + mcs
		callString = "./net_select.py '" + ip + " " + browser + " Per-Node mcs " + mcs + " " + node_id + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()

	#
	#virtual ip
	#
	vir_addrs = ["192.168.10.254", "192.168.10.253"]
	for vir_addr in vir_addrs:
		print "testing virtual_ip_address " + vir_addr
		callString = "./net_textfield.py '" + ip + " " + browser + " Per-Node ipaddr " + vir_addr + " " + node_id + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()
	vir_netmasks = ["255.255.255.0"]
	for vir_netmask in vir_netmasks:
		print "testing virtual_ip_netmask " + vir_netmask
		callString = "./net_textfield.py '" + ip + " " + browser + " Per-Node netmask " + vir_netmask + " " + node_id + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()
	vir_gws = ["192.168.10.1"]
	for vir_gw in vir_gws:
		print "testing virtual_ip_gw " + vir_gw
		callString = "./net_textfield.py '" + ip + " " + browser + " Per-Node gw " + vir_gw + " " + node_id + "'"
		proc = subprocess.Popen(callString, shell=True)
		proc.wait()


	#
	#end of Per-Node test
	#
	print "----- End of Per-Node test -----" 
	f = open('outputfile', 'a') 
	f.write("------------------------" + time.asctime() + "------------------------\n")
	f.write("----- End of Per-Node test -----\n\n")
	f.close()
