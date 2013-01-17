This is UI/Front End repo for Cunxin Project

# Setup on CentOS
* adduser deploy 
* sudo su deploy && mkdir /home/deploy/.ssh/ && chmod 744 /home/deploy/.ssh/ && touch /home/deploy/.ssh/authorized_keys
* copy your product key to authorized_keys
* yum install mysql55-server gcc make zlib-devel openssl-devel libxml2-devel libxslt-devel mysql55-devel sqlite-devel gcc-c++ -y 
* yum localinstall --nogpgcheck http://nodejs.tchol.org/repocfg/amzn1/nodejs-stable-release.noarch.rpm && yum install nodejs
* install rvm (curl -L https://get.rvm.io | bash -s stable --ruby) && echo 'source /home/deploy/.rvm/scripts/rvm' >> ~/.bashrc)
* git clone https://github.com/willamette/cunxin-ui.git
* rvm install ruby-1.9.3-p0
* gem install bundler
* bundle install
-- develop
* rake db:migrate 
* ruby config/seed.rb
* rails s -p 3000 -e development -d

# Add transparent mask for each thumbnail
* convert 2.jpeg -adaptive-resize 320x240! -channel RGBA -fill "rgba(0,0,0,0.5)" -draw "rectangle 0,210,320,240" 2_1.jpeg

# Deployment
* merge your changes to production branch and push it to remote
* add your public key to /home/deploy/.ssh/authorized_keys
* cap deploy

# Setup a new machine
* follow the steps in "Setup on CentOS" section until the "develop" step
* echo "export MAIL_USER=noreply@cunxin.org" >> ~/.bashrc
* echo "export MAIL_PASSWORD=cunxin1" >> ~/.bashrc
* cap deploy:setup && cap deploy:cold
* add the ip into /etc/nginx/conf.d/default.conf and restart nginx
