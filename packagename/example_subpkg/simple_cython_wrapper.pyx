
"""
Cython wrapper for custom_add C function. 
""" 

__all__ = ['cython_wrapped_custom_add']

cimport simple_cython_declarations

def cython_wrapped_custom_add(a, b):

	return simple_cython_declarations.custom_add(a, b)



