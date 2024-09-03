#!/bin/bash

while true; do
    OPTION=$(whiptail --title "User and Group Management" --menu "Choose an option" 25 78 17 \
    "Add User" "Add a user to the system." \
    "Modify User" "Modify an existing user." \
    "Delete User" "Delete an existing user." \
    "List Users" "List last 14 users on the system." \
    "Show User Details" "Display detailed information about a user." \
    "Add Group" "Add a user group to the system." \
    "Modify Group" "Modify a group and its list of members." \
    "Delete Group" "Delete an existing group." \
    "List Groups" "List all groups on the system." \
    "Disable User" "Lock the user account." \
    "Enable User" "Unlock the user account." \
    "Change Password" "Change Password of a user." \
    "About" "Information about this program." \
    3>&1 1>&2 2>&3)

    exit_status=$?

    if [ $exit_status -ne 0 ]; then
        # User pressed Cancel or closed the window
        exit
    fi

    case $OPTION in
        "Add User")
            username=$(whiptail --inputbox "Enter the username to add:" 8 39 --title "Add User" 3>&1 1>&2 2>&3)
            if [ $? -eq 0 ]; then
                password=$(whiptail --passwordbox "Enter the password for the user:" 8 39 --title "Add User" 3>&1 1>&2 2>&3)
                if [ $? -eq 0 ]; then
                    if id "$username" &>/dev/null; then
                        whiptail --msgbox "User $username already exists. Exiting and creating a new user with a random name." 8 60 --title "User Exists"
                        new_username="user$(shuf -i 1000-9999 -n 1)"
                        sudo adduser "$new_username" --gecos "" --disabled-password
                        whiptail --msgbox "Created a new user with the username: $new_username" 8 40 --title "User Created"
                    else
                        sudo useradd "$username" -m -p $(openssl passwd -1 "$password")
                        whiptail --msgbox "User $username has been created successfully." 8 40 --title "User Created"
                    fi
                fi
            fi
            ;;
        "Modify User")
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
            ;;
        "Delete User")
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
            ;;
        "List Users")
            user_list=$(cut -d: -f1 /etc/passwd | tail -n 14)
            if [ -z "$user_list" ]; then
                whiptail --msgbox "No users found." 8 40 --title "List Users"
            else
                whiptail --msgbox "$user_list" 20 60 --title "List Users"
            fi
            ;;
        "Show User Details")
            username=$(whiptail --inputbox "Enter the username to display details for:" 8 39 --title "Show User Details" 3>&1 1>&2 2>&3)
            if [ $? -eq 0 ]; then
                if id "$username" &>/dev/null; then
                    # Gather user details
                    user_info=$(id "$username")
                    user_full_info=$(finger "$username" 2>/dev/null)
                    password_info=$(chage -l "$username" 2>/dev/null)

                    # Display user details
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
            ;;
        "Add Group")
            groupname=$(whiptail --inputbox "Enter the group name to add:" 8 39 --title "Add Group" 3>&1 1>&2 2>&3)
            if [ $? -eq 0 ]; then
                if getent group "$groupname" &>/dev/null; then
                    whiptail --msgbox "Group $groupname already exists. Exiting." 8 40 --title "Group Exists"
                else
                    sudo addgroup "$groupname"
                    whiptail --msgbox "Group $groupname has been created successfully." 8 40 --title "Group Created"
                fi
            fi
            ;;
        "Modify Group")
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
            ;;
        "Delete Group")
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
            ;;
        "List Groups")
            group_list=$(cut -d: -f1 /etc/group | tail -n 14)
            if [ -z "$group_list" ]; then
                whiptail --msgbox "No groups found." 8 40 --title "List Groups"
            else
                whiptail --msgbox "$group_list" 20 60 --title "List Groups"
            fi
            ;;
        "Disable User")
            username=$(whiptail --inputbox "Enter the username to disable:" 8 39 --title "Disable User" 3>&1 1>&2 2>&3)
            if [ $? -eq 0 ]; then
                sudo usermod -L "$username"
                whiptail --msgbox "User $username has been disabled." 8 40 --title "User Disabled"
            fi
            ;;
        "Enable User")
            username=$(whiptail --inputbox "Enter the username to enable:" 8 39 --title "Enable User" 3>&1 1>&2 2>&3)
            if [ $? -eq 0 ]; then
                sudo usermod -U "$username"
                whiptail --msgbox "User $username has been enabled." 8 40 --title "User Enabled"
            fi
            ;;
        "Change Password")
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
            ;;
        "About")
            whiptail --msgbox "Name:Ahmed Mamdouh Mostafa Phone:01143716818 Email:ahmedmamdouh51099@gmail.com                         This is a simple menu for managing users and groups." 12 40 --title "About"
            ;;
        *)
            whiptail --msgbox "Invalid option selected." 8 40 --title "Error"
            ;;
    esac
done

