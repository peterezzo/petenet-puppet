# petenet-puppet
This is a random collection of code that is used to bootstrap some cloud instances for personal use.  An instance is launched in AWS, cloud-init sets some custom facter facts and installs puppet, then pulls down this repo into /etc/puppet to configure the system.

support_scripts is stored here for convenience.