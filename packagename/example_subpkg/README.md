This README gives a brief overview of how to organize a subpackage that includes a C extension wrapped into python using Cython. For more comprehensive documentation on Cython, see cython.org. Further documentation on building C and Cython extensions can be found in the Astropy Developer Docs, http://docs.astropy.org/en/stable/development/ccython.html. 

The example_subpkg sub-package gives an example of how to use Cython to build a C extension of a simple C function. The wrapped C function is called custom_add and located in src/minimal_cext.c; the associated header file is include/minimal_cext.h. To wrap the custom_add function into python, we will need three ingredients: 1. A .pxd definitions file where we make declarations of the C-level constructs that we want our python package to use, 2. a .pyx Cython source code file containing the wrapper, and 3. a setup file that compiles the Cython source file and creates the link to the C-level construct. We'll now sketch each of these ingredients in turn. 

## Cython declarations

The simple_cython_declarations.pxd gives an example of how to make a declaration in Cython for the C-level function custom_add. Files with the .pxd extension provide the link between Cython source code and the C-level declarations.  made .h header files. In this example, simple_cython_declarations.pxd serves as the declaration for custom_add that our Cython source code can recognize. 

## Cython source


Our Cython source code is located in simple_cython_wrapper.pyx. Our C extension was declared with simple_cython_declarations.pxd as described above, and the syntax for loading our C extension is virtually identical to loading a module in pure python, except we use cimport. After doing so, the cython_wrapped_custom_add has access to the C-level custom_add function.  

## Cython compilation

The convention of the package-template is that code which compiles cython source files should be given the filename setup_package.py. With this standardization, when you build packagename from the root directory via "python setup.py build", all code intended to compile Cython source will be automatically detected. Below we only briefly review a few of the conventions related to Cython compilation in your package; for further documentation, see the following section of the Astropy Developer Docs: http://docs.astropy.org/en/stable/development/building.html#customizing-setup-build-for-subpackages. 

The get_extensions function is mechanism used to instruct the Cython compiler how to build your C extension. This function simply returns a list of Extension objects. Instantiating an Extension has two critical arguments: "name" and "sources". The Extension argument "name" determines how our C extension will be called by the rest of the package; in our example, once Cython compiles our extension, we can access it as we would any ordinary python module named "packagename.example_subpkg.simple_cython_wrapper". The Extension argument "sources" determines which Cython and C source files will be compiled together into the packagename.example_subpkg.simple_cython_wrapper extension module. 

## Calling the C extension

There are two ways we can compile our code with the root-level setup.py file, depending on where we want the package to be built. 

1. python setup.py build

This call to the setup file compiles our package and places it in the packagename/build/lib.XXX directory, where XXX will depend on your system's architecture. This is the most common call that users of your package will make, so this is the call you should make if you want to directly test what users will see when the build and use your code. To do so, simply cd into the build/lib.XXX directory and then import your code as you normally would. To call the custom_add C extension, 

from packagename.example_subpkg import simple_cython_wrapper

result = simple_cython_wrapper.cython_wrapped_custom_add(4, 5)

Note that if you do not first cd into the build/lib.XXX directory, and instead try and import simple_cython_wrapper from the packagename root, you will get an ImportError if you try to import example_subpkg. This is because the __init__.py file of example_subpkg is configured to import the simple_cython_wrapper module, but this module is not in the namespace of packagename/example_subpkg, since you have compiled your code into the build/lib.XXX directory, not into the root directory of the package. 

2. python setup.py build_ext --inplace

This call to the setup file compiles our package in-place. When you build your code in this way, you need not cd into the build/lib.XXX directory to call your extension, because the simple_cython_wrapper extension module is built inside packagename/example_subpkg. 








