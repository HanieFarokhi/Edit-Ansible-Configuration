##Edit Ansible Hosts Configuration:

#Edit your Ansible hosts file (/etc/ansible/hosts)
add [Servers]
192.168.1.1
192.168.1.2
192.168.1.3


#ssh-keygen -t rsa

#Create Configuration File:
touch add_ssh_keys.sh
chmod +x add_ssh_keys.sh

#Open add_ssh_keys.sh in a text editor and add the following content:

#!/bin/bash

# Specify the path to your hosts file
HOSTS_FILE="/etc/ansible/hosts-old.ini"

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



#Run the Script:
Execute the script you created:

./add_ssh_keys.sh
ssh username@server_ip
ping hostname_or_ip




