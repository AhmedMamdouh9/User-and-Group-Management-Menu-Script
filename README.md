# User and Group Management Menu Script

This project provides a simple command-line menu interface for managing users and groups on a Unix-based system using `whiptail`. The script allows you to perform various administrative tasks such as adding, modifying, deleting users and groups, as well as managing user passwords.

## Features

- **Add User**: Create a new user with a specified username and password.
- **Modify User**: Rename an existing user and update their home directory.
- **Delete User**: Remove a user and their home directory from the system.
- **List Users**: Display the last 14 users added to the system.
- **Show User Details**: View detailed information about a specific user.
- **Add Group**: Create a new user group.
- **Modify Group**: Rename an existing group.
- **Delete Group**: Remove a group from the system.
- **List Groups**: Display all groups on the system.
- **Disable User**: Lock a user account.
- **Enable User**: Unlock a user account.
- **Change Password**: Update a user's password.
- **About**: Information about the script and author.

## Requirements

- `whiptail`: Used for creating the menu interface.
- `openssl`: Required for password hashing.
- `finger`, `chage`, `last`: For displaying user details.

## Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/user-group-management-script.git
    cd user-group-management-script
    ```

2. **Make the script executable:**

    ```bash
    chmod +x user-group-management.sh
    ```

## Usage

Run the script using `sudo` to ensure it has the necessary permissions to perform administrative tasks:

```bash
sudo ./user-group-management.sh
