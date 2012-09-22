This is UI/Front End repo for Cunxin Project

# Setup on CentOS
* yum install mysql55-server gcc make zlib-devel openssl-devel libxml2-devel libxslt-devel mysql55-devel sqlite-devel gcc-c++ -y 
* yum localinstall --nogpgcheck http://nodejs.tchol.org/repocfg/amzn1/nodejs-stable-release.noarch.rpm && yum install nodejs
* install rvm (curl -L https://get.rvm.io | bash -s stable --ruby) && echo 'source /home/deploy/.rvm/scripts/rvm' >> ~/.bashrc)
* git clone https://github.com/willamette/cunxin-ui.git
* rvm install ruby-1.9.3-p0
* gem install bundler
* bundle install
* rake db:migrate 
* ruby config/seed.rb
* rails s -p 3000 -e development -d

# Add transparent mask for each thumbnail
* convert 2.jpeg -adaptive-resize 320x240! -channel RGBA -fill "rgba(0,0,0,0.5)" -draw "rectangle 0,210,320,240" 2_1.jpeg

# Deployment
* use ssh agent forwarding [https://help.github.com/articles/using-ssh-agent-forwarding]
