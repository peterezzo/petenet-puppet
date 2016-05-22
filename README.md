# petenet-puppet
This is a random collection of code that is used to bootstrap some cloud instances for personal use.  An instance is launched in AWS, cloud-init sets some custom facter facts and installs puppet, then pulls down this repo into /etc/puppet to configure the system.

The bootstrap-puppet.sh script installs several forge modules:

    puppetlabs-stdlib
    puppetlabs-apt
    puppetlabs-git
    puppetlabs-ntp
    herculesteam-augeasproviders_ssh
    herculesteam-augeasproviders_shellvar
    herculesteam-augeasproviders_pam
    herculesteam-augeasproviders_puppet

The aws.py script launches and terminates dev instances with boto3.