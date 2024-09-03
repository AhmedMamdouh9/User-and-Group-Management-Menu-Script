#!/bin/bash

old_groupname=$(whiptail --inputbox "Enter the current group name:" 8 39 --title "Modify Group" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
    new_groupname=$(whiptail --inputbox "Enter the new group name:" 8 39 --title "Modify Group" 3>&1 1>&2 2>&3)
    if [ $? -eq 0 ]; then
        if getent group "$new_groupname" &>/dev/null; then
            whiptail --msgbox "Group $new_groupname already exists. Please choose a different one." 8 60 --title "Group Exists"
        else
            sudo groupmod -n "$new_groupname" "$old_groupname"
            whiptail --msgbox "Group $old_groupname has been renamed to $new_groupname." 8 40 --title "Group Renamed"
        fi
    fi
fi
