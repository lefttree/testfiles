from __future__ import with_statement
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re, sys
import traceback
import signal
from contextlib import contextmanager

class TimeoutException(Exception): pass

@contextmanager
def time_limit(seconds):
	   #what
	def signal_handler(signum, frame):
		raise TimeoutException, "Timed out!"
	signal.signal(signal.SIGALRM, signal_handler)
	signal.alarm(seconds)
	try:
	   yield
 	finally:
	   signal.alarm(0)

class NetworkManager(unittest.TestCase):
    args = sys.argv[1].split(" ")
    # args[0] --- radio_url
    # args[1] --- browser

    def setUp(self):
	args = self.args
        self.getBrowser(args[1])
        self.driver.implicitly_wait(30)
        self.base_url = "http://" + args[0] + "/" 
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

    def test_network_manager(self):
        alertFlag = 0
	driver = self.driver
        driver.get(self.base_url + "netmgmt_dev.html")
	driver.implicitly_wait(100)
	print "checking link_distance alert"
	try:
		with time_limit(5):
			alert1 = driver.switch_to_alert()
			alert1.accept()
			alert1.accept()
			alertFlag = 2
	except:
		alertFlag = 1
		#traceback.print_exc()
		pass
	
	if alertFlag == 2:
		bcast_start_btn = driver.find_element_by_id("bcast_update_start_btn")
		try:
			with time_limit(2):
				alert2 = driver.switch_to_alert()
				alert2.accept()
		except:
			pass
		while not bcast_start_btn:
			bcast_start_btn = driver.find_element_by_id("bcast_update_start_btn")
		bcast_start_btn.click()
		try:
			with time_limit(2):
				alert2 = driver.switch_to_alert()
				alert2.accept()
		except:
			pass
		finally:
			print "link distance set, go on with your test!"
	else:
		print "nonono alert\ngo on with your test!"
	
	    
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
