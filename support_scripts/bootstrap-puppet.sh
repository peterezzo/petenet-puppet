#!/bin/sh

# This script will bootstrap the puppet install on a cloud node for standalone puppet
# it does a hacky detection based on distro /etc files but works so far
# it also assumes that there will not be collisions of required files in /etc/puppet

PUPPETDIR=/etc/puppet

if [ -e /etc/redhat-release ]; then
    echo "Red Hat detected"
    # only support centos7 for now
    rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
    yes | yum -y install puppet
elif [ -e /etc/debian_version ]; then
    echo "Debian detected"
    # only support 14.04 for now
    apt-get -y install wget
    # TODO: this needs a lot more robust verification that download happened!
    wget http://apt.puppetlabs.com/puppetlabs-release-trusty.deb
    dpkg -i /puppetlabs-release-trusty.deb
    apt-get -y update
    apt-get -y install puppet
else
    echo "Unsupported release detected"
    exit 1
fi

gem install librarian-puppet
if [ `which librarian-puppet` ]; then
    cd ${PUPPETDIR}
    librarian-puppet update --verbose
else
    echo "Could not setup librarian-puppet"
    exit 1
fi

if [ `which puppet` ]; then
    # do this a few times to apply consistent state, can we detect errors?
    cd ${PUPPETDIR}
    puppet apply manifests/site.pp
    puppet apply manifests/site.pp
    puppet apply manifests/site.pp
else
    echo "Could not setup puppet"
    exit 1
fi