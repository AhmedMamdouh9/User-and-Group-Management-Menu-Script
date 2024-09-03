#!/bin/bash

username=$(whiptail --inputbox "Enter the username to add:" 8 39 --title "Add User" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
    password=$(whiptail --passwordbox "Enter the password for the user:" 8 39 --title "Add User" 3>&1 1>&2 2>&3)
    if [ $? -eq 0 ]; then
        if id "$username" &>/dev/null; then
            whiptail --msgbox "User $username already exists. Exiting and creating a new user with a random name." 8 60 --title "User Exists"
            new_username="user$(shuf -i 1000-9999 -n 1)"
            sudo adduser "$new_username" --gecos "" --disabled-password
            whiptail --msgbox "Created a new user with the username: $new_username" 8 40 --title "User Created"
        else
            sudo useradd "$username" -m -p $(openssl passwd -1 "$password")
            whiptail --msgbox "User $username has been created successfully." 8 40 --title "User Created"
        fi
    fi
fi
