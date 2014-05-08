#!/bin/bash
#version 0.3
#very very raw and brute :)
#soon: hidemyass,sockslist and spys
#be careful a lot of people runs proxies to sniff traffic|disable javascript etc...
#Need w3m for option 5 | apt-get install w3m
choice=6
 echo "
───────────────────────────────────────────────────────────────────────────────────────────────────
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
 echo "1 ► Http proxy to file http-proxy"
 echo "2 ► Add socks(4) proxies to proxychains"
 echo "3 ► T0r configuration (removes all proxies)"
 echo "4 ► Import socks(4) proxies from file to proxychains(ip:port)"
 echo "5 ► Take proxies from webpage or local file (ip:port)"
 echo -n -e "\033[1m▬▬ι═══════ﺤ \033[0m"
while [ $choice -eq 6 ]; do
 
read choice
if [ $choice -eq 1 ] ; then
 
    echo -e "Take proxies from page: \c "
    read  page
    wget "https://nordvpn.com/free-proxy-list/$page/?allc=all&allp=all&port&sp[0]=1&protocol[0]=HTTP&protocol[1]=HTTPS&ano[0]=High&sortby=0&way=0&pp=3" -O httplist --quiet
    if [ -f http-proxy ]
    then
    echo "Moving old proxy file to http-proxy.old"
    mv http-proxy http-proxy.old
    fi
    grep -oP '(?<=class="row"><td>).*?(?=</td><td><img alt)' httplist > cproxy
    cat cproxy | sed 's|</td><td>|:|g' | sed 's|<[^>]*>|<[^>]*|g' > http-proxy
    rm cproxy httplist
    wc -l http-proxy

else                   

        if [ $choice -eq 2 ] ; then
                 wget "https://nordvpn.com/free-proxy-list/1/?allc=all&allp=all&port&sp[0]=1&protocol[0]=SOCKS4&protocol[1]=SOCKS4%2F5&ano[0]=High&sortby=0&way=0&pp=3" -O sockslist --quiet
                 grep -oP '(?<=class="row"><td>).*?(?=</td><td><img alt)' sockslist > cproxy
                 cat cproxy | sed 's|</td><td>| |g' | sed 's|<[^>]*>|<[^>]*|g' | sed 's/^/socks4 /' >> /etc/proxychains.conf
                 rm cproxy sockslist
                 echo "Done, proxy list imported to /etc/proxychains.conf"
        else
         
                if [ $choice -eq 3 ] ; then
                        echo "Saving old config proxychains.conf.back"
                        cp /etc/proxychains.conf /etc/proxychains.conf.back
                        sed '/socks4/d' /etc/proxychains.conf > /tmp/proxychains
                        mv /tmp/proxychains /etc/proxychains.conf
                        echo "socks4 127.0.0.1 9050" >> /etc/proxychains.conf
                        echo "Done"
                                else
         
                             if [ $choice -eq 4 ] ; then
                              echo -e "Provide patch to file: \c "
                              read  file
                              cat $file | sed 's/^/socks4 /' | sed 's/:/ /' >> /etc/proxychains.conf
                              echo "Done"
                            else
                                  if [ $choice -eq 5 ] ; then
                                  echo -e "Provide url or local patch: \c "
                                  read  url
                                  w3m -dump $url > /tmp/proxyfromurl && grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}:[0-9]\{1,5\}' /tmp/proxyfromurl > proxyfromurl
                                  rm /tmp/proxyfromurl
                                  wc -l proxyfromurl
                          else
                            exit
                        fi
                    fi
                fi   
        fi
fi
done 
