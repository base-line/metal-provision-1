#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get upgrade -y
apt-get install nginx -y

echo "message" >> /root/message.txt
