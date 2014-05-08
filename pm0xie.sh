#!/bin/bash
#very very raw and brute :)
 choice=4
 echo "Proxy m0xie v 0.2"
 echo "1) Download proxy to file http-proxy"
 echo "2) Download proxy and add to /etc/proxychains.conf"
 echo "3) Remove all http-proxies from proxychains.conf"
 echo -n "Thank you nordvpn.com for proxy list!.:: "
while [ $choice -eq 4 ]; do
 
read choice
if [ $choice -eq 1 ] ; then
 
    echo -e "Take proxies from page: \c "
    read  page
    echo "DOWNLOADING FRESH PROXIES"
    wget "https://nordvpn.com/free-proxy-list/$page/?allc=all&allp=all&port&sp[0]=1&protocol[0]=HTTP&protocol[1]=HTTPS&ano[0]=High&sortby=0&way=0&pp=3" -O httplist
    echo "REMOVING OLD"
    rm http-proxy
    echo "Cleaning"
    grep -oP '(?<=class="row"><td>).*?(?=</td><td><img alt)' httplist > cproxy
    cat cproxy | sed 's|</td><td>|:|g' | sed 's|<[^>]*>|<[^>]*|g' > http-proxy
    rm cproxy httplist
    echo "Done, proxy list saved in http-proxy"

else                   

        if [ $choice -eq 2 ] ; then
                 echo -e "Take proxies from page: \c "
                 read  page
                 echo "DOWNLOADING FRESH PROXIES"
                 wget "https://nordvpn.com/free-proxy-list/$page/?allc=all&allp=all&port&sp[0]=1&protocol[0]=HTTP&protocol[1]=HTTPS&ano[0]=High&sortby=0&way=0&pp=3" -O httplist --quiet
                 echo "Cleaning"
                 grep -oP '(?<=class="row"><td>).*?(?=</td><td><img alt)' httplist > cproxy
                 cat cproxy | sed 's|</td><td>| |g' | sed 's|<[^>]*>|<[^>]*|g' | sed 's/^/http /' >> /etc/proxychains.conf
                 rm cproxy httplist
                 echo "Done, proxy list imported to /etc/proxychains.conf"
        else
         
                if [ $choice -eq 3 ] ; then
                        echo "Saving old config proxychains.conf.back"
                        cp /etc/proxychains.conf /etc/proxychains.conf.back
                        echo "Removing old proxies"
                        sed '/http/d' /etc/proxychains.conf > /tmp/proxychains
                        mv /tmp/proxychains /etc/proxychains.conf
                        echo "Done"
                fi   
        fi
fi
done 
