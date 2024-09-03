#!/bin/bash

groupname=$(whiptail --inputbox "Enter the group name to add:" 8 39 --title "Add Group" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
    if getent group "$groupname" &>/dev/null; then
        whiptail --msgbox "Group $groupname already exists. Exiting." 8 40 --title "Group Exists"
    else
        sudo addgroup "$groupname"
        whiptail --msgbox "Group $groupname has been created successfully." 8 40 --title "Group Created"
    fi
fi
