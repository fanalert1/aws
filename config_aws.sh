ssh -i "aws-node.pem" ubuntu@ec2-52-37-58-254.us-west-2.compute.amazonaws.com <<\EOF 

curl -L https://www.chef.io/chef/install.sh | sudo bash

sudo apt-get update

mkdir -p ~/chef/cookbooks/helloworld/recipes

echo '
package "git" do
  action :install
end

package "nodejs" do
  action :install
end

package "npm" do
  action :install
end

execute "create node shortcut" do
  command "sudo ln -s /usr/bin/nodejs /usr/bin/node"
end

package "php5-cli" do
  action :install
end

package "php5-dev" do
  action :install
end

package "php-pear" do
  action :install
end

package "php5-curl" do
  action :install
end

execute "install openssl libraries" do
  command "apt-get install -y autoconf g++ make openssl libssl-dev libcurl4-openssl-dev pkg-config libsasl2-dev libpcre3-dev"
end

execute "install mongodb module" do
  command "pecl install mongodb"
end

execute "update php ini file" do
  command "echo extension=mongodb.so >> /etc/php5/cli/php.ini"
end


execute "create mongodb extenstion file" do
  command "echo extension=mongodb.so >> /etc/php5/cli/conf.d/20-mongodb.ini"
end


execute "install composer" do
  command "curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer"
end

bash "extract_module" do
  code <<-EOH
    mkdir ~/php_scrap
    cd ~/php_scrap
    git init
    git pull https://github.com/fanalert1/php-scrap.git
    touch ~/php_scrap/cron/cron.log
    sudo chmod -R 777 ~/php_scrap
    EOH
end


cron "cron.sh" do
  minute "*/10"
  command "~/php_scrap/cron/cron.sh >> ~/php_scrap/cron/cron.log 2>&1"
  user "ubuntu"
end
' > ~/chef/cookbooks/helloworld/recipes/default.rb


echo '
{
  "run_list": [ "recipe[helloworld]" ]
}' > ~/chef/node.json


echo '
  file_cache_path "/home/ubuntu/chef"
  cookbook_path "/home/ubuntu/chef/cookbooks"
  json_attribs "/home/ubuntu/chef/node.json"
' > ~/chef/solo.rb

sudo chef-solo -c ~/chef/solo.rb

EOF