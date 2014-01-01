#!/bin/bash
# Shell finder 0.3 by flash0re
# Usage: findshell.sh "DIR TO CHECK"
# Todo: ALOT

dir="$1"
#email="$2" 

echo -e "\e[01;32mChecking if log file exists\e[00m"
if [ -e foundsh.log ]; then 
echo -e "\e[01;32mCopying Old Log File | foundsh-old.log\e[00m"
cp foundsh.log foundsh-old.log
rm -f foundsh.log
echo -e "\e[01;32mOld log file removed\e[00m"
fi
echo -e "\e[01;32mMethod #1 | - \e[00m"
find $dir -name 'r57.*' >> foundsh.log
find $dir -name 'c99.*' >> foundsh.log
find $dir -name 'r00t.*' >> foundsh.log
find $dir -name 'ftpcracker.*' >> foundsh.log
find $dir -name 'priv9.*' >> foundsh.log
find $dir -name 'sn22.*' >> foundsh.log
find $dir -name 'ssi.*' >> foundsh.log
find $dir -name 'cgi.r1z' >> foundsh.log
find $dir -name 'config.r1z' >> foundsh.log
find $dir -name 'perlbypass.*' >> foundsh.log
find $dir -name 'vb.php' >> foundsh.log
find $dir -name 'python.izo' >> foundsh.log
find $dir -name 'sh3ll.*' >> foundsh.log
find $dir -name 'she11.*' >> foundsh.log
find $dir -name 'shell.*' >> foundsh.log
find $dir -name 'sh311.*' >> foundsh.log
find $dir -name 'webadmin1.3.aspx' >> foundsh.log
find $dir -name 'ZHC.aspx' >> foundsh.log
find $dir -name 'huiyinb.asp' >> foundsh.log
find $dir -name 'backdoor.*' >> foundsh.log
find $dir -name 'xiaoyao.aspx' >> foundsh.log
echo -e "\e[01;32mMethod #2 | - \e[00m"
grep -r eval.*base64 $dir >> foundsh.log
grep -r FilesMan $dir >> foundsh.log
grep -r "gzinflate(base64_decode" $dir >> foundsh.log
grep -r "eval(" $dir >> foundsh.log
grep -r "system(" $dir >> foundsh.log
grep -r "php_info(" $dir >> foundsh.log
grep -r "fsockopen(" $dir >> foundsh.log
grep -r "shell_exec(" $dir >> foundsh.log
grep -r "chmod(" $dir >> foundsh.log
grep -r "popen(" $dir >> foundsh.log
grep -r "chmod(" $dir >> foundsh.log
grep -r "base64_decode(" $dir >> foundsh.log
if [ -s foundsh.log ]; then
echo -e "\e[01;31mFound suspicious files, Check foundsh.log\e[00m"
#mail -s "Found suspicious files | Check foundsh.log" $email < /dev/null
else
echo -e "\e[01;32mSeems everything okay\e[00m"
fi 
