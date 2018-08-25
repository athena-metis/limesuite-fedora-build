#!/bin/bash

#Install build dependencies
sudo dnf install -y git gcc-c++ cmake libsqlite3x-devel libi2c-devel libusb-devel wxGTK3-devel freeglut-devel gnuplot 

#We will install to /usr/local so we need to tell fedora to look in /usr/local/lib{64}
cat <<EOF | sudo sh -c 'cat > /etc/ld.so.conf.d/local.conf'
/usr/local/lib
/usr/local/lib64
EOF

rm -rf lime-suite-build
mkdir -p lime-suite-build
pushd lime-suite-build

mkdir soapysdr
pushd soapysdr

#Source: https://discourse.myriadrf.org/t/building-limesuite-on-centos-7/1406
git clone https://github.com/pothosware/SoapySDR.git
cd SoapySDR
rm -fr build
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local/ ..
make -j4
sudo make install
sudo ldconfig
SoapySDRUtil --info #test SoapySDR install

sleep 3

popd #Return to lime-suite-build

mkdir limesuite
pushd limesuite

#Source https://discourse.myriadrf.org/t/building-limesuite-on-centos-7/1406
git clone https://github.com/myriadrf/LimeSuite.git
cd LimeSuite
mkdir builddir && cd builddir
cmake ../ -DwxWidgets_USE_STATIC:BOOL=ON -DwxWidgets_CONFIG_EXECUTABLE:FILEPATH=~/bin/wxWidgets-staticlib/bin/wx-config

make -j4
sudo make install
sudo ldconfig

# enable non-root users to access usb-based devices like the LimeSDR
cd ../udev-rules
chmod +x ./install.sh
sudo ./install.sh

popd
popd

rm -rf lime-suite-build
