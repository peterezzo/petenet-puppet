#!/bin/sh

# This script will bootstrap the puppet install on a cloud node for standalone puppet
# it does a hacky detection based on distro /etc files but works so far
# it also assumes that there will not be collisions of required files in /etc/puppet

if [ `which puppet` ]; then:
    # maybe do some version checking here?
    echo "Skipping puppet reinstall"
else
    if [ -e /etc/redhat-release ]; then
        echo "Red Hat detected"
        # only support centos7 for now
        rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
        yes | yum -y install puppet
    elif [ -e /etc/debian_version ]; then
        echo "Debian detected"
        # only support 14.04 for now
        wget http://apt.puppetlabs.com/puppetlabs-release-trusty.deb
        dpkg -i /puppetlabs-release-trusty.deb
        apt-get -y update
        apt-get -y install puppet
    else
        echo "Unsupported release detected"
    fi
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
    puppet apply /etc/puppet/manifests/site.pp
else
    echo "Could not setup puppet"
    exit 1
fi