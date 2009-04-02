# This usually works, but I'm not sure we use the right code for tests here:
#$:<<File.join(File.dirname(__FILE__), '..', 'lib')
# Therefor, ww insert the path to the front of the library paths:
$LOAD_PATH.insert(0, File.join(File.dirname(__FILE__), '..', 'lib'))
require 'richfile'
