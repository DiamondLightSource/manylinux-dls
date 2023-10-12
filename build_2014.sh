#!/bin/bash
set -e -x

ARCH=`uname -m`
if [ $# -gt 0 ]; then
  ARCH=$1
fi

# supplement manylinux_2014
yum install -y epel-release
yum install -y java-11-openjdk

if [ $ARCH == 'x86_64' ]; then
    source add_win32_cross_compile.sh
fi

