#!/bin/bash

# Created by DevAnaZ
# run example below
# docker_build_and_run_for_VPS.sh -c 8080 -p newpassword -u newusername


while getopts ":u:p:c:" opt; do
  case $opt in
    u) username="$OPTARG"
    ;;
    p) password="$OPTARG"
    ;;
    c) port="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done


#making ngrok directory 
mkdir ngrok

#changing directory to ngrok
cd ngrok

#removing all existing files 
rm * 

#removing all existing folders 
rm -r *

#downloading ngrok stable from official webserver
wget 'https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip'

#unzipping ngrok-stable-linux-amd64.zip in selected folder
unzip ngrok-stable-linux-amd64.zip

#asking ngrok auth token
echo " Go to ngrok.io in any browser & signin or signup, copy the ngrok auth token and paste here, ngrok token only  (example - 4OXX56rxxxI00QGKnXXXXZ0_3xSAyW24irP0A0ie0bo0B),Readme - https://github.com/developeranaz/cloudshell-novnc-automation   Ngrok Auth token: "
read input_token
echo "You entered: $input_token"
./ngrok authtoken $input_token

cd
apt install git -y
rm -r .devanaztempinstall
mkdir .devanaztempinstall
cd .devanaztempinstall
git clone https://github.com/developeranaz/qbittorrent-to-rclone-heroku
cd qbittorrent-to-rclone-heroku

docker build .

docker images |head -2| tail -1 |sed 's/ /\n/g' |sed '/^$/d' |head -3| tail -1 >imagename

cd
rm -r .devanaztempinstall
docker run -td -e username="$username" -e password="$password" -p $port:8880 "$(docker images |head -2| tail -1 |sed 's/ /\n/g' |sed '/^$/d' |head -3| tail -1)"

./ngrok http 8080
