#!/bin/bash

userExists=`cat /etc/passwd | grep $DEFAULT_USERNAME`

if [ -z "$userExists" ]; then
    echo "Creating SFTP group..."
	addgroup sftpgroup
	echo "Creating SFTP user..."
	mkdir -p /home/$DEFAULT_USERNAME
	adduser -D $DEFAULT_USERNAME -G sftpgroup -h /$DEFAULT_USERNAME
	chown -R $DEFAULT_USERNAME:sftpgroup /home/$DEFAULT_USERNAME
	chmod -R 755 /home/$DEFAULT_USERNAME
fi

echo "Setting SFTP user password..."
echo $DEFAULT_USERNAME:$DEFAULT_PASSWORD | chpasswd
echo "Initialization complete!"