#!/bin/bash

groupname=$(whiptail --inputbox "Enter the group name to delete:" 8 39 --title "Delete Group" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
    confirm=$(whiptail --yesno "Are you sure you want to delete the group $groupname? This will remove the group from the system." 8 60 --title "Confirm Deletion" 3>&1 1>&2 2>&3)
    if [ $? -eq 0 ]; then
        sudo delgroup "$groupname"
        whiptail --msgbox "Group $groupname has been deleted successfully." 8 40 --title "Group Deleted"
    else
        whiptail --msgbox "Group deletion canceled." 8 40 --title "Canceled"
    fi
else
    whiptail --msgbox "No group name entered or action canceled." 8 40 --title "Action Canceled"
fi
