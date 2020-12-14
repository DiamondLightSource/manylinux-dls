#!/bin/bash
set -e -x

# Require SWIG > 1.3.40 for Centos 6
SWIGPREFIX=swig-2.0.10-5
SWIGSRC=${SWIGPREFIX}.el7.src.rpm
curl -fsSLO https://vault.centos.org/7.9.2009/os/Source/SPackages/$SWIGSRC

yum install -y rpm-build python-devel dos2unix perl-devel perl-Test-Simple boost-devel

rpmbuild --quiet --rebuild $SWIGSRC --without testsuite --define 'guile 0' --define 'tcl 0'
rpm -i /root/rpmbuild/RPMS/x86_64/${SWIGPREFIX}*.rpm

# clean up
# remove build packages
yum history rollback -y last-1
rm $SWIGSRC
rm -rf /root/rpmbuild

# supplement manylinux_2010
yum install -y java-1.8.0-openjdk-devel pcre-devel

