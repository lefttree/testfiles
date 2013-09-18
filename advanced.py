from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re
import sys, jsonrpclib

class Advanced(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://172.20.4.127/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_advanced(self):
	#split arguments
	args = sys.argv[1].split(" ")
	#driver setup	
        driver = self.driver
        driver.get(self.base_url + args[0]) #get webinterface2.sh
	#
	#test link_distance textfields
	#
	if args[1] == "link_distance":
		textfield = driver.find_element_by_name(args[1]) #element name
		textfield.clear()
        	textfield.send_keys(args[2]) #input value
        driver.find_element_by_name("advance1").click()
    	driver.find_element_by_name("advance1").click() #double to make click and wait

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

if __name__ == "__main__":
	unittest.main(argv=sys.argv[1:])
