#!/bin/bash

# add cross-compiler for C
# for Centos 7, need to use copr as mingw packages withdrawn from EPEL
grep -q 'release 7' /etc/centos-release
if [ $? -eq 0 ]; then
    yum install -y yum-plugin-copr
    yum copr enable -y alonid/mingw-epel7
fi
yum install -y mingw64-gcc

# install jdk for Windows
JDK_DIR=jdk-11.0.14.1+1
JDK_ZIP=OpenJDK11U-jdk_x64_windows_hotspot_11.0.14.1_1.zip
JDK_SHA=3e7da701aa92e441418299714f0ed6db10c3bb1e2db625c35a2c2cd9cc619731
curl -OL "https://github.com/adoptium/temurin11-binaries/releases/download/$JDK_DIR/$JDK_ZIP"
echo -e "$JDK_SHA  $JDK_ZIP\n" > SHA256.SUM
sha256sum -c SHA256.SUM
if [ $? -ne 0 ]; then
   echo "Hash mismatch for zip of JDK" >&2
   exit -1
fi

unzip $JDK_ZIP -d /opt
rm -f $JDK_ZIP SHA256.SUM

mv /opt/$JDK_DIR /opt/jdk-11-win32

