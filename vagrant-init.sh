#!/usr/bin/env bash

echo "Provisioning virtual machine..."

set -ex

PG_VERSION=9.3

if ls ~/.initial_provision* 1> /dev/null 2>&1; then
  echo 'Already provisioned'
else
  sudo apt-get update -y && sudo apt-get upgrade -y
  sudo /usr/sbin/update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
  sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties "postgresql-$PG_VERSION" "postgresql-contrib-$PG_VERSION" libpq-dev imagemagick nodejs -y

  echo "Setting up Ruby via rbenv"
  git clone git://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  git clone git://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/vagrant/.bashrc

  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

  rbenv install 2.1.3
  rbenv global 2.1.3
  echo "Current Ruby is $(ruby -v)"
  sudo echo "gem: --no-ri --no-rdoc" > /home/vagrant/.gemrc
  gem install bundler --no-ri --no-rdoc
  rbenv rehash

  # Non beta, not updated
  # gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
  # gpg --armor --export 561F9B9CAC40B2F7 | sudo apt-key add -
  # sudo apt-get install apt-transport-https -y
  # sudo sh -c "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' >> /etc/apt/sources.list.d/passenger.list"
  # sudo chown vagrant /etc/apt/sources.list.d/passenger.list
  # sudo chmod 600 /etc/apt/sources.list.d/passenger.list
  # sudo apt-get update -y
  # sudo apt-get install nginx-full passenger -y

  # Updated
  # sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
  # sudo apt-get install apt-transport-https ca-certificates
  # sudo sh -c "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' >> /etc/apt/sources.list.d/passenger.list"
  # sudo chown vagrant /etc/apt/sources.list.d/passenger.list
  # sudo chmod 600 /etc/apt/sources.list.d/passenger.list
  # sudo apt-get update -y
  # sudo apt-get install nginx-extras passenger -y

  # With Nginx, non-gem install (see above)
  # sudo service nginx start
  # sudo sed -i 's/# passenger_root \/usr\/lib\/ruby\/vendor_ruby\/phusion_passenger\/locations.ini;/passenger_root \/usr\/lib\/ruby\/vendor_ruby\/phusion_passenger\/location.ini;/g' /etc/nginx/nginx.conf
  # sudo sed -i 's/# passenger_ruby \/usr\/bin\/ruby;/passenger_ruby \/home\/vagrant\/.rbenv\/shims\/ruby;/g' /etc/nginx/nginx.conf
  # sudo service nginx restart

  sudo apt-get install postgresql libpq-dev -y
  sudo mkdir -p /usr/local/pgsql/data
  sudo chown postgres:postgres /usr/local/pgsql/data
  sudo -u postgres -H sh -c "/usr/lib/postgresql/$PG_VERSION/bin/initdb -D /usr/local/pgsql/data"
  sudo -u postgres -H sh -c "createuser vagrant"
  sudo -u postgres psql postgres -c "ALTER ROLE vagrant CREATEDB;"

  # might need
  # sudo -i -H sh -c "echo 'local all all trust' >> /etc/postgresql/$PG_VERSION/main/pg_hba.conf"
  # sudo -i -H sh -c "sed -i \"s/#listen_addresses = 'localhost'/listen_addresses = '*'/\" \"/etc/postgresql/$PG_VERSION/main/postgresql.conf\""
  # sudo -i -H sh -c "echo \"host    all             all             all                     md5\" >> \"/etc/postgresql/$PG_VERSION/main/pg_hba.conf\""
  # sudo -i -H sh -c "echo \"client_encoding = utf8\" >> \"/etc/postgresql/$PG_VERSION/main/postgresql.conf\""

  cd /vagrant
  gem install bundler
  bundle install
  # rake db:create
  # rake db:migrate

  touch ~/.initial_provision
  echo $(date) > ~/.initial_provision
fi
