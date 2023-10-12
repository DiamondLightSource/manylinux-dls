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
JDK_VERSION=11.0.20.1
JDK_BUILD=1
JDK_DIR=jdk-${JDK_VERSION}+${JDK_BUILD}
JDK_ZIP=OpenJDK11U-jdk_x64_windows_hotspot_${JDK_VERSION}_${JDK_BUILD}.zip
JDK_SHA=5042f5ed28f84faf545eba6bb9ce59288fb9c85c0de8d30803e9fc1a88d533c4

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

