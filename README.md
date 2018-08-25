# Limesuite (LimeSDR) build script for Fedora
This has only be tested in a non-fresh copy of Fedora 28 so your mileage may vary (there may be additional dependencies that need installing, or slightly different package names).

Most of the build instructions were sourced from:-
https://discourse.myriadrf.org/t/building-limesuite-on-centos-7/1406

With some changes to cater for Fedora rather than CentOS

This script will destroy any folder named lime-suite-build in the same folder as it, so if you have a folder of this name where you are going to run this script and you still want it, move it now.

Installation will occur into /usr/local and your system will be set to additionally look for library files in /usr/local/lib and /usr/local/lib64

After installation if you can run any commands please ensure that /usr/local/bin and /usr/local/sbin are in your PATH environment variable.

After a successful install you should be able to run any of the following:

SoapySDRUtil

LimeQuickTest

LimeUtil
