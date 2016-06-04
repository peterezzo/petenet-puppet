#!/bin/sh

# this script is a static form of the AWS userdata to bootstrap a local machine
# if an arg is passed use it as role
# must be run as root

mkdir -vp /etc/facter/facts.d
echo "hostgroup=local" > /etc/facter/facts.d/hostgroup.txt

if [ "$1" ]; then
    echo "role=$1" > /etc/facter/facts.d/role.txt
fi

if [ -e /etc/redhat-release ]; then
    echo "Red Hat detected"
    yum -y install git
elif [ -e /etc/debian_version ]; then
    echo "Debian detected"
    apt-get -y update
    apt-get -y install git
fi

git clone https://github.com/peterezzo/petenet-puppet.git /etc/puppet
/bin/sh /etc/puppet/support_scripts/bootstrap-puppet.sh