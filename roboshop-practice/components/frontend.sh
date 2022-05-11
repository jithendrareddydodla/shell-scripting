#!/usr/bin/env bash

source components/common.sh

CheckRootUser

  echo "INSTALLING NGINX"
  yum install nginx -y >/tmp/roboshop_output.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m This stage is Sucess\e[0m"
else
   echo -e "\e[31m This stage is Failure\e[0m"
  exit 1
fi

  echo "ENABLING NGINX"
  systemctl enable nginx >/tmp/roboshop_output.log
  if [ $? -eq 0 ]; then
    echo -e "\e[32m This stage is Sucess\e[0m"
  else
     echo -e "\e[31m This stage is Failure\e[0m"
    exit 1
  fi

  echo "STARTING NGINX"
  systemctl start nginx >/tmp/roboshop_output.log
  if [ $? -eq 0 ]; then
    echo -e "\e[32m This stage is Sucess\e[0m"
  else
     echo -e "\e[31m This stage is Failure\e[0m"
    exit 1
  fi

  echo "LOADING FILE FROM GITHUB"
  curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >/tmp/roboshop_output.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m This stage is Sucess\e[0m"
else
   echo -e "\e[31m This stage is Failure\e[0m"
  exit 1
fi

  cd  /usr/share/nginx/html >/tmp/roboshop_output.log
  rm -rf *

  echo "UNZIPING FILES"
  unzip /tmp/frontend.zip >/tmp/roboshop_output.log
  if [ $? -eq 0 ]; then
    echo -e "\e[32m This stage is Sucess\e[0m"
  else
     echo -e "\e[31m This stage is Failure\e[0m"
    exit 1
  fi

  mv frontend-main/* . >/tmp/roboshop_output.log
  mv static/* . >/tmp/roboshop_output.log
  rm -rf frontend-main README.md
  mv localhost.conf /etc/nginx/default.d/roboshop.conf >/tmp/roboshop_output.log

  echo "RESTARTING NGINX"
  systemctl restart nginx >/tmp/roboshop_output.log
  if [ $? -eq 0 ]; then
    echo -e "\e[32m This stage is Sucess\e[0m"
  else
     echo -e "\e[31m This stage is Failure\e[0m"
    exit 1
  fi




