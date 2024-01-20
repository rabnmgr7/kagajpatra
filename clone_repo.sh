#!/bin/bash
echo "Provide information of remote host to clone this repo:"
echo "Username:"
read username
echo "host ip:"
read host
ssh "$username"@"$hostname"
sudo su
cd /opt/
git clone https://github.com/rabnmgr7/kagajpatra.git
