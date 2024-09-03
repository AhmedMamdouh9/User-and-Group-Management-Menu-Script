#!/bin/bash

username=$(whiptail --inputbox "Enter the username to delete:" 8 39 --title "Delete User" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
    confirm=$(whiptail --yesno "Are you sure you want to delete the user $username? This will remove the user and their home directory." 8 60 --title "Confirm Deletion" 3>&1 1>&2 2>&3)
    if [ $? -eq 0 ]; then
        sudo deluser --remove-home "$username"
        whiptail --msgbox "User $username has been deleted successfully." 8 40 --title "User Deleted"
    else
        whiptail --msgbox "User deletion canceled." 8 40 --title "Canceled"
    fi
else
    whiptail --msgbox "No username entered or action canceled." 8 40 --title "Action Canceled"
fi
