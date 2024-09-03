#!/bin/bash

username=$(whiptail --inputbox "Enter the username to enable:" 8 39 --title "Enable User" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
    sudo usermod -U "$username"
    whiptail --msgbox "User $username has been enabled." 8 40 --title "User Enabled"
fi
