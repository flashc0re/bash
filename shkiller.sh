#!/bin/bash
# Shell killer 0.1 by flash0re
# Simple script to find shells
# Usage: shkiller.sh "DIR TO CHECK"


dir="$1"
echo -e "\e[01;32mMethod #1 90% Rate (encoded)\e[00m"
grep -r eval.*base64 $dir >> shkiller.log 
echo -e "\e[01;32mMethod #2 FilesMan (uncoded, example: WSO)\e[00m"
grep -r FilesMan $dir >> shkiller.log
echo -e "\e[01;32mDone results saved: shkiller.log \e[00m"
