#!/bin/bash

username=$(whiptail --inputbox "Enter the username to change password:" 8 39 --title "Change Password" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
    new_password=$(whiptail --passwordbox "Enter the new password for $username:" 8 39 --title "Change Password" 3>&1 1>&2 2>&3)
    if [ $? -eq 0 ]; then
        retype_password=$(whiptail --passwordbox "Retype the new password for $username:" 8 39 --title "Change Password" 3>&1 1>&2 2>&3)
        if [ $? -eq 0 ]; then
            if [ "$new_password" = "$retype_password" ]; then
                echo "$username:$new_password" | sudo chpasswd
                whiptail --msgbox "Password for $username has been changed successfully." 8 40 --title "Password Changed"
            else
                whiptail --msgbox "Passwords do not match. Password change canceled." 8 40 --title "Error"
            fi
        fi
    fi
fi
