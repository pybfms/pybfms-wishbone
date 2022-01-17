
import os

import sys, os.path, platform, warnings

from distutils import log
from distutils.core import setup, Command

VERSION = None
with open("etc/ivpm.info") as fp:
  for line in fp:
    if line.find("version=") != -1:
      VERSION = line[line.find("=")+1:].strip()
      break

if VERSION is None:
  print("Error: null version")

if "BUILD_NUM" in os.environ:
  VERSION += "." + os.environ["BUILD_NUM"]

try:
    from wheel.bdist_wheel import bdist_wheel
except ImportError:
    bdist_wheel = None

cmdclass = {
}
if bdist_wheel:
    cmdclass['bdist_wheel'] = bdist_wheel

setup(
  name = "pybfms-wishbone",
  version=VERSION,
  packages=['wishbone_bfms'],
  package_dir = {'' : 'src'},
  package_data = {'wishbone_bfms': ['hdl/*.v']},
  author = "Matthew Ballance",
  author_email = "matt.ballance@gmail.com",
  description = ("wishbone_bfms provides bus functional models for Wishbone protocol"),
  license = "Apache 2.0",
  keywords = ["SystemVerilog", "Verilog", "RTL", "cocotb"],
  url = "https://github.com/pybfms/wishbone_bfms",
  setup_requires=[
    'setuptools_scm',
  ],
  cmdclass=cmdclass,
  install_requires=[
    'cocotb',
    'pybfms',
  ],
)

