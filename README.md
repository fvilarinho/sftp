** Introduction **

SFTP is an application which allows you to upload files in a safe way. 

** How to run it **

docker run -p 22:22 -e DEFAULT_PORT=22 DEFAULT_USERNAME=username -e DEFAULT_PASSWORD=password -d innovativethinking/sftp

Then just connect through a sftp client:

sftp username@localhost

** Author **

Felipe Vilarinho 

fvilarinho@innovativethinking.com.br

+55 11 9 8222-9197