#!/bin/bash

username=$(whiptail --inputbox "Enter the username to display details for:" 8 39 --title "Show User Details" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
    if id "$username" &>/dev/null; then
        user_info=$(id "$username")
        user_full_info=$(finger "$username" 2>/dev/null)
        password_info=$(chage -l "$username" 2>/dev/null)

        detailed_info="Login: $username\n"
        detailed_info+="$(echo "$user_full_info" | grep -E 'Name:|Directory:|Shell:')\n"
        detailed_info+="Last login: $(last -F "$username" | head -1 | awk '{print $4, $5, $6, $7}')\n"
        detailed_info+="No mail.\n"
        detailed_info+="No Plan.\n"
        detailed_info+="$password_info"

        whiptail --msgbox "$detailed_info" 20 60 --title "User Details"
    else
        whiptail --msgbox "User $username does not exist." 8 40 --title "User Not Found"
    fi
fi

