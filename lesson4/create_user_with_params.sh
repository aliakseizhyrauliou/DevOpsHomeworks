#!/bin/bash

if [[ $# -lt 4 ]]; then
    echo "4 agrguments required: -user_name -home_folder -ssh_access -enable"
    exit 1
fi

while [[ $# -gt 0 ]]; do
  case $1 in
    -user_name=*)
      user_name="${1#*=}"
      ;;
    -home_folder=*)
      home_folder="${1#*=}"
      ;;
    -ssh_access=*)
      if [[ "${1#*=}" != "true" && "${1#*=}" != "false" ]]; then
        echo "Error: Incorrect value for -ssh_access: ${1#*=}. Correct arguments: true, false"
        exit 1
      fi
      ssh_access="${1#*=}"
      ;;
    -enable=*)
      if [[ "${1#*=}" != "true" && "${1#*=}" != "false" ]]; then
        echo "Error: Incorrect value for -enable: ${1#*=}. Correct arguments: true, false"
        exit 1
      fi
      enable="${1#*=}"
      ;;
    *)
      echo "Ошибка: Некорректный аргумент: $1"
      exit 1
      ;;
  esac
  shift
done

sudo useradd -m -d $home_folder $user_name

sudo passwd "$user_name"

echo "user $user_name was created with with $home_folder home folder"

if [[ $enable = "true" ]]; then
    echo "user enable"
else 
    echo "user disabled"
fi

if [[ $ssh_access = "true" ]]; then
    echo "ssh access enable"
else 
    echo "ssh access disabled"
fi

