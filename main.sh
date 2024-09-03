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
        exit
    fi

    case $OPTION in
        "Add User")
            ./add_user.sh
            ;;
        "Modify User")
            ./modify_user.sh
            ;;
        "Delete User")
            ./delete_user.sh
            ;;
        "List Users")
            ./list_users.sh
            ;;
        "Show User Details")
            ./show_user_details.sh
            ;;
        "Add Group")
            ./add_group.sh
            ;;
        "Modify Group")
            ./modify_group.sh
            ;;
        "Delete Group")
            ./delete_group.sh
            ;;
        "List Groups")
            ./list_groups.sh
            ;;
        "Disable User")
            ./disable_user.sh
            ;;
        "Enable User")
            ./enable_user.sh
            ;;
        "Change Password")
            ./change_password.sh
            ;;
        "About")
            ./about.sh
            ;;
        *)
            whiptail --msgbox "Invalid option selected." 8 40 --title "Error"
            ;;
    esac
done
