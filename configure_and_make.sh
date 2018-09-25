#!/bin/sh

user=`whoami`

if [ $user != "root" ] ; then
   echo -e "$user :: Please run me as root\n"
   exit 1
fi

yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
yum clean all 
yum makecache
yum groupinstall "development tools"
yum install rpm-build pcre-devel pam-devel zlib-devel openssl-devel git rpmdevtools python-devel librsync-devel rpm-build

rpmdev-setuptree
cp -rpfv SOURCES/* /root/rpmbuild/SOURCES/
cp -rpfv nginx.spec /root/rpmbuild/SPECS/
cd /root/rpmbuild/SOURCES
wget https://github.com/sto/ngx_http_auth_pam_module/archive/v1.5.1.tar.gz
wget https://nginx.org/download/nginx-1.15.3.tar.gz
mv v1.5.1.tar.gz ngx_http_auth_pam_module-1.5.1.tar.gz
cd /root/rpmbuild/SPECS 
rpmbuild -ba nginx.spec
cp -rpfv /root/rpmbuild/SRPMS/*.rpm /root/
cp -rpfv /root/rpmbuild.orig/RPMS/x86_64/*.rpm /root/

