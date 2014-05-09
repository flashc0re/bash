#!/bin/bash
#version 0.4
#very very dirty :) next proxy checking & harvester
#be careful a lot of people runs proxies to sniff traffic|disable javascript etc...
#Need w3m for option 6 | apt-get install w3m
choice=7
 echo "───────────────────────────────────────────────────────────────────────────────────────────────────
─██████████████─██████──────────██████─██████████████─████████──████████─██████████─██████████████─
─██░░░░░░░░░░██─██░░██████████████░░██─██░░░░░░░░░░██─██░░░░██──██░░░░██─██░░░░░░██─██░░░░░░░░░░██─
─██░░██████░░██─██░░░░░░░░░░░░░░░░░░██─██░░██████░░██─████░░██──██░░████─████░░████─██░░██████████─
─██░░██──██░░██─██░░██████░░██████░░██─██░░██──██░░██───██░░░░██░░░░██─────██░░██───██░░██─────────
─██░░██████░░██─██░░██──██░░██──██░░██─██░░██──██░░██───████░░░░░░████─────██░░██───██░░██████████─
─██░░░░░░░░░░██─██░░██──██░░██──██░░██─██░░██──██░░██─────██░░░░░░██───────██░░██───██░░░░░░░░░░██─
─██░░██████████─██░░██──██████──██░░██─██░░██──██░░██───████░░░░░░████─────██░░██───██░░██████████─
─██░░██─────────██░░██──────────██░░██─██░░██──██░░██───██░░░░██░░░░██─────██░░██───██░░██─────────
─██░░██─────────██░░██──────────██░░██─██░░██████░░██─████░░██──██░░████─████░░████─██░░██████████─
─██░░██─────────██░░██──────────██░░██─██░░░░░░░░░░██─██░░░░██──██░░░░██─██░░░░░░██─██░░░░░░░░░░██─
─██████─────────██████──────────██████─██████████████─████████──████████─██████████─██████████████─
───────────────────────────────────────────────────────────────────────────────────────────────────
                                                              Thank you nordvpn.com for proxy list"
 echo -e "\033[1mPROXYCHAINS MENU\033[0m"
 echo "1 ► Add proxy list (ip:port)"
 echo "2 ► Get socks(4) proxy list & add"
 echo "3 ► Put tor socks4 (removes all previous proxies)"
 echo "4 ► Remove all proxies"
 echo -e "\033[1mExtra\033[0m"
 echo "5 ► Get http proxy list"
 echo "6 ► Grab proxy list from webpage or file (ip:port)"
 echo "press ctrl+c to exit"
 echo -n -e "\033[1m▬▬ι═══════ﺤ \033[0m"
while [ $choice -eq 7 ]; do
 
read choice

        if [ $choice -eq 1 ] ; then
                     echo -e "Provide path to file: \c "
                     read  file
                     echo "proxy types: http socks4 socks5"
                     echo -e "Type of proxy: \c "
                     read  proxy
                     cat $file | sed "s/^/$proxy /" | sed 's/:/ /' >> /etc/proxychains.conf
                     echo -e '\E[47;31m'"\033[1mDone\033[0m" 

        else                   

        if [ $choice -eq 2 ] ; then
                 wget "https://nordvpn.com/free-proxy-list/1/?allc=all&allp=all&port&sp[0]=1&protocol[0]=SOCKS4&protocol[1]=SOCKS4%2F5&ano[0]=High&sortby=0&way=0&pp=3" -O /tmp/pm0xie-tmpfile --quiet
                 grep -oP '(?<=class="row"><td>).*?(?=</td><td><img alt)' /tmp/pm0xie-tmpfile > /tmp/pm0xie-tmpfile2
                 cat /tmp/pm0xie-tmpfile2 | sed 's|</td><td>| |g' | sed 's|<[^>]*>|<[^>]*|g' | sed 's/^/socks4 /' >> /etc/proxychains.conf
                 rm /tmp/pm0xie-tmpfile2 /tmp/pm0xie-tmpfile
                 echo -e '\E[47;31m'"\033[1mDone, proxy list imported to /etc/proxychains.conf\033[0m" 

        else
         
                if [ $choice -eq 3 ] ; then
                        echo "Saving old config proxychains.conf.back"
                        cp /etc/proxychains.conf /etc/proxychains.conf.back
                        sed -e '/socks4/d' -e '/http/d' -e '/socks5/d' /etc/proxychains.conf > /tmp/proxychains
                        mv /tmp/proxychains /etc/proxychains.conf
                        echo "socks4 127.0.0.1 9050" >> /etc/proxychains.conf
                        echo -e '\E[47;31m'"\033[1mDone\033[0m" 

        else

                if [ $choice -eq 4 ] ; then
                        echo "Saving old config proxychains.conf.back"
                        cp /etc/proxychains.conf /etc/proxychains.conf.back
                        sed -e '/socks4/d' -e '/http/d' -e '/socks5/d' /etc/proxychains.conf > /tmp/proxychains
                        mv /tmp/proxychains /etc/proxychains.conf
                        echo -e '\E[47;31m'"\033[1mDone\033[0m" 

        else
                if [ $choice -eq 5 ] ; then
                        echo -e "Take proxies from page: \c "
                        read  page
                        wget "https://nordvpn.com/free-proxy-list/$page/?allc=all&allp=all&port&sp[0]=1&protocol[0]=HTTP&protocol[1]=HTTPS&ano[0]=High&sortby=0&way=0&pp=3" -O /tmp/pm0xie-tmpfile --quiet
                        if [ -f hproxy.txt ]
                        then
                        echo -e '\E[47;31m'"\033[1mMoving old proxy file to hproxy.txt.old\033[0m" 
                        mv hproxy.txt hproxy.txt.old
                        fi
                        grep -oP '(?<=class="row"><td>).*?(?=</td><td><img alt)' /tmp/pm0xie-tmpfile > /tmp/pm0xie-tmpfile2
                        cat /tmp/pm0xie-tmpfile2 | sed 's|</td><td>|:|g' | sed 's|<[^>]*>|<[^>]*|g' > hproxy.txt
                        rm /tmp/pm0xie-tmpfile2 /tmp/pm0xie-tmpfile
                        echo -e '\E[47;31m'"\033[1m`realpath hproxy.txt && wc -l hproxy.txt`\033[0m" 

        else

                if [ $choice -eq 6 ] ; then
                    echo -e "Provide url or local path: \c "
                    read  url
                    w3m -dump $url > /tmp/pm0xie-tmpfile && grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}:[0-9]\{1,5\}' /tmp/pm0xie-tmpfile > gproxy.txt
                    rm /tmp/pm0xie-tmpfile
                    echo -e '\E[47;31m'"\033[1m`realpath gproxy.txt && wc -l gproxy.txt`\033[0m" 
                      else
                         echo -e '\E[47;31m'"\033[1mNo such command\033[0m"  
                          fi
                        fi
                    fi
                fi   
        fi
fi
. pm0xie.sh
done 
