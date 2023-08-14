#!/bin/bash

default_home="/home"

create_user() {
  local username="$1"
  local home_folder="${2:-${default_home}/${username}}"  # Используем значение по умолчанию, если home_folder не передан
  local ssh="$3"
  local is_enable="$4"
  
  if [[ -z "$username" ]]; then
    echo "Имя пользователя не указано"
    return 1
  fi
  
  sudo useradd -m -d "$home_folder" "$username"
  sudo passwd "$username"
  
  echo "========================================"
  echo "Пользователь $username создан с домашней папкой $home_folder"

  if [[ $is_enable = "true" ]]; then
    echo "Пользователь включен"
  else 
    echo "Пользователь отключен"
  fi

  if [[ $ssh = "true" ]]; then
    echo "SSH доступ включен"
  else 
    echo "SSH доступ отключен"
  fi
}

readFromFileAndCreateUsers() {
  local ssh="$2"
  local is_enable="$3"

  if [[ $# -lt 1 ]]; then 
    echo "Укажите путь к файлу"
    exit 1
  fi
  
  file_path="$1"
  
  if [[ ! -f "$file_path" ]]; then
    echo "Файл не найден: $file_path"
    exit 1
  fi
  
  while IFS= read -r username; do
    create_user "$username" "" "$ssh" "$is_enable"
  done < "$file_path"
}



validate_arguments() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      -user_name=*)
        user_name="${1#*=}"
        ;;
      -home_folder=*)
        home_folder="${1#*=}"
        ;;
      -ssh_access)
        ssh_access="true"
        ;;
      -enable)
        enable="true"
        ;;
      -user_names_file_path=*)
        user_names_file_path="${1#*=}"
        ;;
      *)
        echo "Ошибка: Некорректный аргумент: $1"
        exit 1
        ;;
    esac
    shift
  done
}


# Проверка правильности аргументов
validate_arguments "$@"

# Если передан путь к txt файлу с именами пользователей
if [[ ! -z "$user_names_file_path" ]]; then
  readFromFileAndCreateUsers "$user_names_file_path" "$ssh_access" "$enable"
else
  create_user "$user_name" "$home_folder" "$ssh_access" "$enable"
fi


