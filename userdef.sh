#!/bin/bash

if [ $# -lt 3 ]; then
        echo "Error: Wrong passing of arguments"
fi

username=$1
userpass=$2
groupname=$3


if [ -z "$username" ]; then
        echo "Error: Username cannot be empty."
        echo "exiting.."
        exit 
fi

if [ -z "$userpass" ]; then
        echo "Error: User password cannot be empty."
        echo "exiting.."
        exit 
fi

if [ -z "$groupname" ]; then
        echo "Error: Group name cannot be empty."
        echo "exiting.."
        exit 
fi


if [ $EUID -ne 0 ]; then
        echo "Error: script needs sudo permission"
        echo "exiting.."
	exit 
fi

{ echo username= $1 
  echo userpass= $2
  echo groupname= $3
} 

sudo useradd -m -s /bin/bash "$username"

echo "$username:$userpass" | sudo chpasswd

echo "User successfully created"
id $username

if [ $username == $groupname ]; then
        echo "Error: Group name cant be the same as user name"
        echo "exiting.."
        exit
else
	sudo groupadd -g 200 $groupname
	sudo usermod -aG $groupname $username
fi

echo "User added to group $groupname"
id $username

sudo usermod -u 1600 $username
sudo usermod -g $groupname $username

echo "User Id and primary group changed successfully"
id $username




