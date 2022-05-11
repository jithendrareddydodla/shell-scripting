CheckRootUser() {
    USER_ID=$(id -u)

  if [ "$USER_ID" -ne "0" ]; then
    echo -e "\e[31mYou need to run this as root user\e[om"
    exit 1
  else
    echo -e "\e[32mwiat scritp is running.....\e[0m"
  fi
}
