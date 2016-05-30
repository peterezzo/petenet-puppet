#!/bin/sh

# this script is a static form of the AWS userdata to bootstrap a local machine
# if an arg is passed use it as role
# must be run as root

mkdir -vp /etc/facter/facts.d
echo "hostgroup=local" > /etc/facter/facts.d/hostgroup.txt

if [[ "$1" ]]; then
    echo "role=$1" > /etc/facter/facts.d/role.txt
fi

if [[ `which yum` ]]; then
    yum -y install git
else
    apt-get install git
fi

git clone https://github.com/peterezzo/petenet-puppet.git /etc/puppet
/bin/sh /etc/puppet/support_scripts/bootstrap-puppet.sh
puppet apply /etc/puppet/manifests/site.pp