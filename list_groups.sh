#!/bin/bash

group_list=$(cut -d: -f1 /etc/group | tail -n 14)
if [ -z "$group_list" ]; then
    whiptail --msgbox "No groups found." 8 40 --title "List Groups"
else
    whiptail --msgbox "$group_list" 20 60 --title "List Groups"
fi
