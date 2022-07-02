# Written by: Wahaj Javed Alam
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.support.ui import Select
import time
driver = webdriver.Chrome()
driver.get("https://www.thesparksfoundationsingapore.org/")
print("Tests\n")

print("\nTestCase 1: Verify Title")
if driver.title == "The Sparks Foundation | Home":
    print("\nTitle Verified Successfully: " + driver.title + "\n")
else:
    print("\nTitle Verification Failed!\n")

print("TestCase 2:  Verify Navbar")
try:
    driver.find_element(By.CLASS_NAME, "navbar")
    print("Navbar Verification Successful!\n")
except NoSuchElementException:
    print("Navbar Verification Failed!\n")

print("TestCase 3: Clicking the About us dropdown and moving to the next page")
try:
    driver.find_element(By.LINK_TEXT, 'About Us').click()
    time.sleep(3)
    driver.find_element(By.LINK_TEXT, 'News').click()
    time.sleep(3)
    print('Page visited Successfully!\n')
except NoSuchElementException:
    print("Page visit Failed! Does not exist.\n")
    time.sleep(3)

print("TestCase 4: Opening Guiding Principles")
try:
    driver.find_element(By.LINK_TEXT, "Guiding Principles").click()
    print("Successfully opened the guiding principles\n")
    time.sleep(3)
except NoSuchElementException:
    print("Guiding principles do not exist\n")

print("TestCase 5: Going back to Home Page")
try:
    driver.find_element(By.PARTIAL_LINK_TEXT, "The Sparks Foundation").click()
    print("Home link is working!\n")
except NoSuchElementException:
    print("Home Link Doesn't Work!\n")

print("TestCase 6: Checking Whistle Blowing Policies")
try:
    driver.find_element(By.LINK_TEXT, 'Policies and Code').click()
    time.sleep(3)
    driver.find_element(By.LINK_TEXT, "Whistle Blowing Policy").click()
    time.sleep(3)
    print('Whistle Blowing Policies Verified!\n')
except NoSuchElementException:
    print('Whistle Blowing Policies do not exist\n')

print("TestCase 7: Checking Workshops")
try:
    driver.find_element(By.LINK_TEXT, 'Programs').click()
    time.sleep(3)
    driver.find_element(By.LINK_TEXT, "Workshops").click()
    time.sleep(3)
    print('Workshops Verified!\n')
except NoSuchElementException:
    print('Workshops page does not exist!\n')

print("TestCase 8: Verifying Address")
try:
    driver.find_element(By.LINK_TEXT, "Contact Us").click()
    time.sleep(3)
    address = driver.find_element(By.XPATH,
                                  '/html/body/div[2]/div/div/div[2]/div[2]/p')
    time.sleep(3)
    if address.text == """THE HANGAR, NUS ENTERPRISE
21 HENG MUI KENG TERRACE, SINGAPORE, 119613""":
        print("Address is Verified\n")
except NoSuchElementException:
    print("Address Verification Unsuccessful!\n")

print("TestCase 9: Go to Brand Ambassadors page")
try:
    driver.find_element(By.LINK_TEXT, 'Brand Ambassador').click()
    time.sleep(3)
    print('Brand Ambassador Page Exists!\n')
except NoSuchElementException:
    print("Brand Ambassador page doesnt exist!\n")

print("TestCase 10: Interacting with join us form")
try:
    driver.find_element(By.LINK_TEXT, 'Join Us').click()
    time.sleep(3)
    driver.find_element(By.LINK_TEXT, 'Why Join Us').click()
    time.sleep(3)
    name = driver.find_element(By.NAME, 'Name')
    name.send_keys("Wahaj Javed")
    time.sleep(3)
    email = driver.find_element(By.NAME, 'Email')
    email.send_keys('wahaj.javed02@gmail.com')
    time.sleep(3)
    select = Select(driver.find_element(By.CLASS_NAME, 'form-control'))
    time.sleep(3)
    select.select_by_visible_text('Intern')
    time.sleep(3)
    driver.find_element(By.CLASS_NAME, 'button-w3layouts').click()
    time.sleep(3)
    print("Form Submitted and Verified!\n")
except NoSuchElementException:
    print("Form Could not be submitted!\n")
    time.sleep(3)

driver.close()
