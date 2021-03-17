#!/bin/bash

EXISTS=`cat /etc/passwd | grep $USER`

if [ -z "$EXISTS" ]; then
    echo "Creating the default user group..."
    
	addgroup sftp
	
	echo "Creating the default user..."
	
	mkdir -p /sftp
	adduser -D $USER -G sftp -h /sftp
	chown -R $USER /sftp
	chmod -R o-rwx /sftp
fi
echo "Setting the default user password..."

echo $USER:$PASSWORD | chpasswd