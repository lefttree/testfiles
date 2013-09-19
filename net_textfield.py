#!/usr/bin/python
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re
import jsonrpclib
import sys


class NetTextfield(unittest.TestCase):
    args = sys.argv[1].split(" ")
    # args[0] --- radio_url
    # args[1] --- browser
    # args[2] --- tab_name
    # args[3] --- name of element
    # args[4] --- value
    # args[5] --- node_id

    def setUp(self):
	args = self.args
	self.getBrowser(args[1])  #setup browser
	self.driver.implicitly_wait(30)
	self.base_url = "http://" + args[0] + "/netmgmt_dev.html"  #set base radio_url
	self.verificationErrors = []
	self.accept_next_alert = True

    def getBrowser(self, browser):
	if browser == "firefox" or browser == "Firefox":
		self.driver = webdriver.Firefox()
	elif browser == "chrome" or browser == "Chrome":
		self.driver = webdriver.Chrome()
	elif browser == "ie" or browser == "IE":
		print "No IE on Linux"
	else:
		self.driver = webdriver.Frefox()

    def test_net_textfield(self):
	args = self.args
        driver = self.driver
        driver.get(self.base_url)
        #go to tab
	driver.find_element_by_partial_link_text(args[2]).click()
	self.typeText(args[2], args[3], args[4], args[5])
	self.submitForm(args[2])
	self.checkText(args[2])
	rResult = self.getRadioValue(args[0], args[3])
	#
	#rResult = self.convertValue2Text(rResult, args[3])
	#
	self.writeToFile(rResult, args[3], args[4])

    
    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException, e: return False
        return True
    
    def is_alert_present(self):
        try: self.driver.switch_to_alert()
        except NoAlertPresentException, e: return False
        return True
    
    def close_alert_and_get_its_text(self):
        try:
            alert = self.driver.switch_to_alert()
            alert_text = alert.text
            if self.accept_next_alert:
                alert.accept()
            else:
                alert.dismiss()
            return alert_text
        finally: self.accept_next_alert = True
    
    def tearDown(self):
        self.driver.quit()
        self.assertEqual([], self.verificationErrors)

    def typeText(self, tab, element, value, node_id):
	driver = self.driver
	if tab == "Network-wide":
		click_id = element + "_chkbox_bcast"
		clickElement =  driver.find_element_by_id(click_id)
		clickElement.click()
		text_id = element + "_input_bcast"
	elif tab == "Per-Node":
		xpath = "//li[@id='" + node_id + "']" 
		clickElement = driver.find_element_by_xpath(xpath)
		clickElement.click()
		text_id = element + "_input"
	textElement = driver.find_element_by_id(text_id)
	textElement.clear()
	textElement.send_keys(value)

    def submitForm(self, tab):
	if tab == "Network-wide":
		print "click button"
		self.clickButton("bcast_update_start_btn")
	elif tab == "Per-Node":
		self.clickButton("per_node_apply_btn")

    def clickButton(self, buttonId):
	button = self.driver.find_element_by_id(buttonId)
	button.click()
	button.click()

    def checkText(self, tab):
	if tab == "Network-wide":
		textff = self.driver.find_element_by_id("bcast_update_status_msg").text
		while textff != "All nodes updated!":
			textff = self.driver.find_element_by_id("bcast_update_status_msg").text
		print "updated!"
	elif tab == "Per-Node":
		self.assertEqual("Node updated successfully!", self.close_alert_and_get_its_text())

    def getRadioValue(self, radio_url, element):
	jsonrpc_url = "http://" + radio_url + "/streamscape_api"
	server = jsonrpclib.Server(jsonrpc_url)
	if element == "link_distance":
		radioResult = server.max_link_distance()
	elif element == "ipaddr":
		radioResult = server.virtual_ip_address()
	elif element == "netmask":
		radioResult = server.virtual_ip_netmask()
	elif element == "gw":
		radioResult = server.vir_ip_gateway()
	
	rResult = radioResult[0].encode('ascii', 'ignore')
	return rResult

    def writeToFile(self, rResult, element, value):
	rResult = rResult.upper()
	value = value.upper()
	f = open('outputfile', 'a')
	if rResult == value:
		print element + " "
		print rResult
		print "updated correctly\n"
	else:
		print element + " "
		print rResult
		print "! wrong !\n"
		f.write("wrong! " + element + "\n")
		f.write("radio value is " + rResult)
		f.write("; test value is " + value)
		f.write("\n")
	f.close()

if __name__ == "__main__":
	unittest.main(argv=sys.argv[1:])
