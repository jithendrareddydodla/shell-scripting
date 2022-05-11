CheckRootUser() {
    USER_ID=$(id -u)

  if [ "$USER_ID" -ne "0" ]; then
    echo -e "\e[31mYou need to run this as root user\e[om"
    exit 1
  else
    echo -e "\e[32m wait scritp is running.....\e[0m"
  fi
}

Statuscheck()  {

   if [ $? -eq 0 ]; then
      echo -e "\e[32m This stage is Sucess\e[0m"
    else
       echo -e "\e[31m This stage is Failure\e[0m"
      exit 1
    fi
}


LOG_FILE=/tmp/roboshop_output.log
rm -f $(LOG_FILE)



