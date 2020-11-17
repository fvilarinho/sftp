#!/bin/bash

EXISTS=`cat /etc/passwd | grep $USER`

if [ -z "$EXISTS" ]; then
    echo "Creating the default user group..."
    
	addgroup sftpgroup
	
	echo "Creating the default user..."
	
	mkdir -p /home/$USER
	adduser -D $USER -G sftpgroup -h /$USER
	chown -R $USER /home/$USER
	chmod -R 755 /home/$USER
fi
echo "Setting the default user password..."

echo $USER:$PASSWORD | chpasswd