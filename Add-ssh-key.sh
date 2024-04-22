#!/bin/bash

# Specify the path to your hosts file
HOSTS_FILE="/HOST/CONFIG/FILE"

# Specify the path to your SSH key
SSH_KEY_PATH="$HOME/.ssh/id_rsa.pub"

# Database password
DB_PASSWORD="your_db_password"

# Loop through each server IP in the hosts file and add the SSH key
while IFS= read -r server_ip; do
    # Check if server_ip is not empty
    if [[ -n "$server_ip" ]]; then
        # Use sshpass to provide the password non-interactively
        if sshpass -p "$DB_PASSWORD" ssh-copy-id -i "$SSH_KEY_PATH" -f "db@$server_ip"; then
            echo "SSH key added successfully to $server_ip"
        else
            echo "Error: SSH connection failed to $server_ip"
        fi
    else
        echo "Error: Empty server IP"
    fi
done < "$HOSTS_FILE"
