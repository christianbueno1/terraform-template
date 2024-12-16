#!/bin/bash

sudo dnf update -y
# unzip is yet installed
sudo dnf install bash-completion vim-enhanced httpd wget -y

systemctl enable httpd
systemctl start httpd

sudo wget https://www.tooplate.com/download/2135_mini_finance.zip

# create directory sample.com/public_html
sudo mkdir -p /var/www/sample.com/public_html

sudo unzip 2135_mini_finance.zip -d /var/www/sample.com/public_html

sudo systemctl restart httpd
echo "<h1>Welcome to Amazon Linux 2023!</h1><p>"O mueres siendo un héroe o vives lo suficiente para verte convertido en un villano."</p>" > /var/www/html/index.html