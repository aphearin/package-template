
"""
Cython wrapper for custom_add C function. 
""" 

cimport simple_cython_declarations

def cython_wrapped_custom_add(a, b):

	return simple_cython_declarations.custom_add(a, b)



