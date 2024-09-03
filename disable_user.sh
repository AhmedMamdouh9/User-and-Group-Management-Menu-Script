#!/bin/bash

username=$(whiptail --inputbox "Enter the username to disable:" 8 39 --title "Disable User" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
    sudo usermod -L "$username"
    whiptail --msgbox "User $username has been disabled." 8 40 --title "User Disabled"
fi
