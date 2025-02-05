---
layout: post
title: "Python advanced"
date: 2022-01-10 12:25:06
description: Python, OOP, decorate, lib, pythonic, pytest
tags:
 - code
---


# decorate
func as an input and output

```
def printargs(inputfunc):
	def outputfunc(*args, **kwargs):
		print("Function {} called with args = {} and kwargs = {}".format(inputfunc.__name__, args, kwargs))
		return inputfunc(*args, **kwargs)
	return outputfunc
@printargs
def fibonacci(n):
	if n < 2:
		return 1
	return fibonacci(n-1) + fibonacci(n-2)

```

# OOP
data(state) + method(behaviour)
```
class Turtle:
	def __init__(self):
		self.pos=(0,0)
		self.angle=0
		self.pen=True
	def forward(self, distance):
		pass
	def back(self, distance):
		pass

```

# pytest
pytest -v src/tests/test_abc.py::test_check
[patch decorator](https://www.fugue.co/blog/2016-02-11-python-mocking-101)
```
from xx import Point
def test_make_one_point():
	p1 = Point("Dakar", 12.32, 16.10)
	assert p1.get_lat_long() == (12.32, 16.10)
def test_invalid_point_generation():
	with pytest.raises(Exception) as exp:
		Point("Buenos Aires", -999, -999)
	assert str(exp.value) ==  'Invalid latitude, longitude)'

class Point():
	def __init__(self, name, latitude, longitude):
		self.name = name
		if not (-90 <= latitude <=90) or not (-90 <=longitude <=90):
			raise ValueError("Invalid latitude, longitude")
		self.latitude = latitude
		self. longitude = longitude
	def get_lat_long(self):
		return (self.latitude, self.longitude)

```
# yield
The yield statement suspends a function’s execution and sends a value back to the caller, but retains enough state to enable the function to resume where it left off. When the function resumes, it continues execution immediately after the last yield run. This allows its code to produce a series of values over time, rather than computing them at once and sending them back like a list.

```
def simpleGeneratorFun():
    yield 1
    yield 2
    yield 3
for value in simpleGeneratorFun():
    print(value)
```

# perf
[refer](https://jakevdp.github.io/PythonDataScienceHandbook/01.07-timing-and-profiling.html)
```
python3 -m timeit '"-".join(str(n) for n in range(100))'

import timeit
timeit.timeit('"-".join(str(n) for n in range(100))', number=10000)
```

# unittest
patch will modify the behaviour/pointer of the object in the test function
```
# my_module.py
import requests

def fetch_data(url):
    response = requests.get(url)
    return response.json()


# test_my_module.py
import unittest
from unittest.mock import patch
from my_module import fetch_data

class TestMyModule(unittest.TestCase):
    @patch('my_module.fetch_data') #the function in the specific module be called, not the defintion one
    def test_fetch_data(self, mock_fetch_data: MagicMock):
        # Mock the return value of fetch_data
        mock_fetch_data.return_value = MagicMock(key="value",attribute="X")

        # Call the function
        result = fetch_data('http://example.com')

        # Assert the function was called
        mock_fetch_data.assert_called_once_with('http://example.com')

        # Assert the result is as expected
        self.assertEqual(result, {'key': 'value'})

if __name__ == '__main__':
    unittest.main()
```
