echo 'Installing Pip...'; InstallPip
echo 'Installing Flask...';
sudo pip install flask
yum -y install httpd
yum install postgresql
pip install Flask
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

if which puppet > /dev/null ; then
        echo "Puppet is already installed"
        exit 0
fi

echo "Installing Puppet repo for Ubuntu 12.04 LTS"
wget -qO /tmp/puppetlabs-release-precise.deb \
        https://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i /tmp/puppetlabs-release-precise.deb
rm /tmp/puppetlabs-release-precise.deb
yum update
#aptitude upgrade -y
echo Installing puppet
sudo yum install puppet
echo "Puppet installed!"