#!/bin/bash

user_list=$(cut -d: -f1 /etc/passwd | tail -n 14)
if [ -z "$user_list" ]; then
    whiptail --msgbox "No users found." 8 40 --title "List Users"
else
    whiptail --msgbox "$user_list" 20 60 --title "List Users"
fi
