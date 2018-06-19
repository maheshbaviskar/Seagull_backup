import unittest;
from testing_fun import get_formatted_name

class NamesTestCase(unittest.TestCase):    
	"""Tests for 'name_function.py'."""       
	def test_first_last_name(self):
		"""Do names like 'Janis Joplin' work?"""          
		formatted_name = get_formatted_name('janis', 'joplin')          
		try:
			self.assertEqual(formatted_name, 'Janis Joplin')
			print("\n" + "*"*10 + "Passed" + "*" * 10)
		except AssertionError:
			print("Failed")


unittest.main()
 


