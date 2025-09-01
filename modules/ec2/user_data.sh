#!/bin/bash
yum update -y
yum install -y nginx
systemctl start nginx
systemctl enable nginx
echo "<h1>Welcome to Nginx on AWS</h1><p>Server is running on $(hostname -f)</p>" > /var/www/html/index.html