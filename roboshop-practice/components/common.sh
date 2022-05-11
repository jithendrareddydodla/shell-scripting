CheckRootUser() {
    USER_ID=$(id -u)

  if [ "$USER_ID" -ne "0" ]; then
    echo -e "\e[31mYou need to run this as root user\e[om"
    exit 4
  else
    echo -e "\e[32mok\e[0m"
    fi
}
