This is UI/Front End repo for Cunxin Project

# Setup on CentOS
* yum install mysql55-server gcc make zlib-devel openssl-devel libxml2-devel libxslt-devel mysql55-devel sqlite-devel -y 
* yum localinstall --nogpgcheck http://nodejs.tchol.org/repocfg/amzn1/nodejs-stable-release.noarch.rpm && yum install nodejs
* install rvm (curl -L https://get.rvm.io | bash -s stable --ruby) && echo 'source /home/deploy/.rvm/scripts/rvm' >> ~/.bashrc)
* git clone https://github.com/willamette/cunxin-ui.git
* rvm install ruby-1.9.3-p0
* gem install bundler
* bundle install
* rake db:migrate 
* ruby config/seed.rb
* rails s -p 3000 -e development -d

