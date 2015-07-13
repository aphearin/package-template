# Licensed under a 3-clause BSD style license
from __future__ import absolute_import

import os
from distutils.extension import Extension

ROOT = os.path.relpath(os.path.dirname(__file__))

def get_extensions():
    sources = [os.path.join(ROOT, 'simple_cython_wrapper.pyx')]
    ext = Extension(
        name="packagename.example_subpkg.minimal_cext",
        sources=sources)
    return [ext]

def requires_2to3():
    return False

def get_package_data():
    return {'packagename.example_subpkg': ['include/*.h']}