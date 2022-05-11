#!/usr/bin/env bash

source components/common.sh

CheckRootUser

  echo "INSTALLING NGINX"
  yum install nginx -y >>${LOG_FILE}
  Statuscheck

  echo "ENABLING NGINX"
  systemctl enable nginx >>${LOG_FILE}
  Statuscheck

  echo "STARTING NGINX"
  systemctl start nginx >>${LOG_FILE}
  Statuscheck

  echo "LOADING FILE FROM GITHUB"
  curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >>${LOG_FILE}
  Statuscheck

  cd  /usr/share/nginx/html >>${LOG_FILE}
  rm -rf *

  echo "UNZIPING FILES"
  unzip /tmp/frontend.zip >>${LOG_FILE}
  Statuscheck

  mv frontend-main/* . >>${LOG_FILE}
  mv static/* . >>${LOG_FILE}
  rm -rf frontend-main README.md
  mv localhost.conf /etc/nginx/default.d/roboshop.conf >>${LOG_FILE}

  echo "RESTARTING NGINX"
  systemctl restart nginx >>${LOG_FILE}
  Statuscheck




