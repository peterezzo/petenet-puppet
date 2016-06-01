#!/bin/sh

# This script will bootstrap the puppet install on a cloud node so it's not all in userdata
# it does a hacky detection based on distro /etc files
# it also assumes that there will not be collisions of required files in /etc/puppet

if [ -e /etc/redhat-release ]; then
    echo "Red Hat detected"
    # only support centos7 for now
    rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
    yes | yum -y install puppet
elif [ -e /etc/debian_version ]; then
    echo "Debian detected"
    apt-get -y install puppet
else
    echo "Unsupported release detected"
fi

if [ `which puppet` ]; then
    puppet module install puppetlabs-stdlib
    puppet module install puppetlabs-apt
    puppet module install puppetlabs-git
    puppet module install puppetlabs-ntp
    puppet module install herculesteam-augeasproviders_ssh
    puppet module install herculesteam-augeasproviders_shellvar
    puppet module install herculesteam-augeasproviders_pam
    puppet module install herculesteam-augeasproviders_puppet
else
    echo "Could not install puppet modules"
    exit 1
fi