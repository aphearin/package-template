
"""
Cython wrapper for custom_add C function. 
""" 

from src.minimal_cext cimport custom_add 

def wrapper(a, b):

	return custom_add(a, b)



