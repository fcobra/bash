#!/bin/bash
c_red='\e[0;31m'
c_green='\e[0;32m'
c_blue='\e[0;34m'
c_white='\e[1;37m'
c_gray='\e[0;37m'
c_orange='\e[0;33m'
c_NC='\e[0m' # No Color

CURRENT_FOLDER="${PWD}";

echo -ne "${c_white}(!) Run script from root TimeWeb user folder${c_NC}. Continue? [y/n] ";
read -p "" ANSWER;
if [[ $ANSWER =~ ^[Yy]$ ]]
then
    echo -ne "";
else
    exit 1;
fi

# Site Folder
echo -ne "Enter site folder (ex. site.ru): ";
read -p "" SITE_FOLDER;
if [ -z "${SITE_FOLDER}" ]
then
    echo -ne "\n${c_red}You don't enter site folder. By!${c_NC}\n\n"
    exit 1;
fi

# Create site address
mkdir -p "${CURRENT_FOLDER}/${SITE_FOLDER}/.git/";
mkdir -p "${CURRENT_FOLDER}/${SITE_FOLDER}/www/frontend/public_html/";
mkdir -p "${CURRENT_FOLDER}/${SITE_FOLDER}/www/backend/public_html/";
mkdir -p "${CURRENT_FOLDER}/aidmin.${SITE_FOLDER}/";
ln -s "${CURRENT_FOLDER}/${SITE_FOLDER}/www/backend/public_html/" "${CURRENT_FOLDER}/aidmin.${SITE_FOLDER}/public_html";
ln -s "${CURRENT_FOLDER}/${SITE_FOLDER}/www/frontend/public_html/" "${CURRENT_FOLDER}/${SITE_FOLDER}/public_html";
cd "${CURRENT_FOLDER}/${SITE_FOLDER}/.git/";
git --bare init