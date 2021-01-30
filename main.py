from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# https://selenium-python.readthedocs.io/getting-started.html
# https://gist.github.com/WillKoehrsen/127fb3963b12b4f0b339ff0c8ee14558
# https://towardsdatascience.com/controlling-the-web-with-python-6fceb22c5f08

# Using Chrome to access web
driver = webdriver.Chrome()
# Open the website
driver.get('https://wolframalpha.com')

# https://selenium-python.readthedocs.io/api.html#selenium.webdriver.support.expected_conditions.visibility_of_element_located
# https://www.selenium.dev/selenium/docs/api/py/webdriver/selenium.webdriver.common.by.html
entry_field = WebDriverWait(driver, 10).until(EC.visibility_of_element_located((By.CLASS_NAME, "_2oXzi")))
entry_field.send_keys("y = sin(cos(x))")

# https://selenium-python.readthedocs.io/api.html#selenium.webdriver.support.expected_conditions.element_to_be_clickable
compute_button = WebDriverWait(driver, 10).until(EC.element_to_be_clickable((By.CLASS_NAME, "_10um4._2DVTv.HuMWM")))
compute_button.click()
