CheckRootUser() {
    USER_ID=$(id -u)

  if [ "$USER_ID" -ne "0" ]; then
    echo you need to run this as root user
    exit
  else
    echo ok
    fi
}
