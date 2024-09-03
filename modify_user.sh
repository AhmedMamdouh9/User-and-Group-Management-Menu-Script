#!/bin/bash

old_username=$(whiptail --inputbox "Enter the current username:" 8 39 --title "Modify User" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
    new_username=$(whiptail --inputbox "Enter the new username:" 8 39 --title "Modify User" 3>&1 1>&2 2>&3)
    if [ $? -eq 0 ]; then
        if id "$new_username" &>/dev/null; then
            whiptail --msgbox "Username $new_username already exists. Please choose a different one." 8 60 --title "Username Exists"
        else
            sudo usermod -l "$new_username" "$old_username"
            sudo usermod -d "/home/$new_username" -m "$new_username"
            whiptail --msgbox "User $old_username has been renamed to $new_username." 8 40 --title "User Renamed"
        fi
    fi
fi
