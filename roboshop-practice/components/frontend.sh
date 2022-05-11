#!/usr/bin/env bash

source components/common.sh

CheckRootUser

  echo "INSTALLING NGINX"
  yum install nginx -y >>Logfileoutput
  Statuscheck

  echo "ENABLING NGINX"
  systemctl enable nginx >>Logfileoutput
  Statuscheck

  echo "STARTING NGINX"
  systemctl start nginx >>Logfileoutput
  Statuscheck

  echo "LOADING FILE FROM GITHUB"
  curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >>Logfileoutput
  Statuscheck

  cd  /usr/share/nginx/html >>Logfileoutput
  rm -rf *

  echo "UNZIPING FILES"
  unzip /tmp/frontend.zip >>Logfileoutput
  Statuscheck

  mv frontend-main/* . >>Logfileoutput
  mv static/* . >>Logfileoutput
  rm -rf frontend-main README.md
  mv localhost.conf /etc/nginx/default.d/roboshop.conf >>Logfileoutput

  echo "RESTARTING NGINX"
  systemctl restart nginx >>Logfileoutput
  Statuscheck




