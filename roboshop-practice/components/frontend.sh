#!/usr/bin/env bash

source components/common.sh

CheckRootUser

  echo "INSTALLING NGINX"
  yum install nginx -y >/tmp/roboshop_output.log

  echo "ENABLING NGINX"
  systemctl enable nginx >/tmp/roboshop_output.log

  echo "STARTING NGINX"
  systemctl start nginx >/tmp/roboshop_output.log

  echo "LOADING FILE FROM GITHUB"
  curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >/tmp/roboshop_output.log

  cd  /usr/share/nginx/html >/tmp/roboshop_output.log
  rm -rf *

  echo "UNZIPING FILES"
  unzip /tmp/frontend.zip >/tmp/roboshop_output.log
  mv frontend-main/* . >/tmp/roboshop_output.log
  mv static/* . >/tmp/roboshop_output.log
  rm -rf frontend-main README.md
  mv localhost.conf /etc/nginx/default.d/roboshop.conf >/tmp/roboshop_output.log

  echo "RESTARTING NGINX"
  systemctl restart nginx >/tmp/roboshop_output.log




