#!/bin/bash

c_red='\e[0;31m'
c_green='\e[0;32m'
c_blue='\e[0;34m'
c_white='\e[1;37m'
c_gray='\e[0;37m'
c_orange='\e[0;33m'
c_NC='\e[0m' # No Color

echo -ne "${c_green}Enter DB name:${c_NC} ";
read -p "" MYSQL_DB;

echo -ne "${c_green}Create DB?${c_NC} [y/n] "
read -p "" ANSWER;

if [[ $ANSWER =~ ^[Yy]$ ]]
then
    if [ -z "$MYSQL_DB" ]
    then
        echo -ne "\n${c_red}You don't enter DB name. By!${c_NC}\n\n"
        exit 1;
    else
        echo -ne "${c_orange}Enter MySQL root password${c_NC}\n";
        echo 'CREATE DATABASE IF NOT EXISTS `'"${MYSQL_DB}"'` CHARACTER SET utf8 COLLATE utf8_general_ci;' | mysql -uroot -p
    fi
fi

echo -ne "${c_green}GRANT ALL PRIVILEGES TO USER?${c_NC} [y/n] "
read -p "" ANSWER;

if [[ $ANSWER =~ ^[Yy]$ ]]
then
    echo -ne "${c_green}Enter DB user:${c_NC} ";
    read -p "" MYSQL_USER;

    if [ -z "$MYSQL_USER" ]
    then
        echo -ne "\n${c_red}You don't enter DB user. By!${c_NC}\n\n"
        exit 1;
    else

        echo -ne "${c_green}Create DB user $MYSQL_USER in DB?${c_NC} [y/n] "
        read -p "" ANSWER;
        if [[ $ANSWER =~ ^[Yy]$ ]]
        then
            echo -ne "${c_green}Enter DB user $MYSQL_USER password:${c_NC} ";
            read -p "" MYSQL_USER_PASSWORD;
            echo -ne "${c_orange}Enter MySQL root password${c_NC}\n";
            echo 'GRANT ALL PRIVILEGES on `'"${MYSQL_DB}"'`.* to `'"${MYSQL_USER}"'`@'localhost' identified by "'"${MYSQL_USER_PASSWORD}"'"; FLUSH PRIVILEGES;' | mysql -uroot -p
        else
            echo -ne "${c_orange}Enter MySQL root password${c_NC}\n";
            echo 'GRANT ALL PRIVILEGES on `'"${MYSQL_DB}"'`.* to `'"${MYSQL_USER}"'`@'localhost'; FLUSH PRIVILEGES;' | mysql -uroot -p
        fi

        echo -ne "${c_red}REVOKE ALL PRIVILEGES TO DB USER ${MYSQL_USER}?${c_NC} [y/n] "
        read -p "" ANSWER;
        if [[ $ANSWER =~ ^[Yy]$ ]]
        then
            echo -ne "${c_orange}Enter MySQL root password${c_NC}\n";
            echo 'REVOKE ALL PRIVILEGES on `'"${MYSQL_DB}"'`.* from `'"${MYSQL_USER}"'`@'localhost'; FLUSH PRIVILEGES;' | mysql -uroot -p
        fi

        echo -ne "${c_red}DROP DB USER ${MYSQL_USER}?${c_NC} [y/n] "
        read -p "" ANSWER;
        if [[ $ANSWER =~ ^[Yy]$ ]]
        then
            echo -ne "${c_orange}Enter MySQL root password${c_NC}\n";
            echo 'DROP USER `'"${MYSQL_USER}"'`@'localhost';' | mysql -uroot -p
        fi
    fi
fi

echo -ne "${c_red}DROP DB ${MYSQL_DB}?${c_NC} [y/n] "
read -p "" ANSWER;
if [[ $ANSWER =~ ^[Yy]$ ]]
then
    echo -ne "${c_orange}Enter MySQL root password${c_NC}\n";
    echo 'DROP DATABASE IF EXISTS `'"${MYSQL_DB}"'`' | mysql -uroot -p
fi

exit 0;