#!/bin/bash

#####################################
# Drop MySQL tables and views in DB #
#####################################

MUSER="$1"
MPASS="$2"
MDB="$3"

# Detect paths
MYSQL=$(which mysql)
AWK=$(which awk)
GREP=$(which grep)

# Functions
exitErr ()
{
        echo "Usage: $0 {MySQL-User-Name} {MySQL-User-Password} {MySQL-Database-Name}";
        exit 1;
}

# Check income data
if [ -z "${MUSER}" ]
then
	echo -ne "Enter MySQL user: "
	read -p "" MUSER;
	if [ -z "$MUSER" ]
	then
		exitErr
	fi
fi

if [ -z "${MPASS}" ]
then
        echo -ne "Enter MySQL user password: "
        read -p "" MPASS;
        if [ -z "$MPASS" ]
        then
                exitErr
        fi
fi

if [ -z "${MDB}" ]
then
        echo -ne "Enter MySQL databse name: "
        read -p "" MDB;
        if [ -z "$MDB" ]
        then
                exitErr
        fi
fi

# Deleting process

TABLES=$($MYSQL -u $MUSER -p$MPASS $MDB -e 'show full tables where Table_type="BASE TABLE"' | $AWK '{print $1}' | $GREP -v '^Tables')

for t in $TABLES
do
        echo "Deleting $t table from $MDB database..."
        $MYSQL -u $MUSER -p$MPASS $MDB -e "SET FOREIGN_KEY_CHECKS=0; drop table $t; SET FOREIGN_KEY_CHECKS=1;"
done

VIEWS=$($MYSQL -u $MUSER -p$MPASS $MDB -e 'show full tables where Table_type="VIEW"' | $AWK '{print $1}' | $GREP -v '^Tables')

for t in $VIEWS
do
        echo "Deleting $t view from $MDB database..."
        $MYSQL -u $MUSER -p$MPASS $MDB -e "SET FOREIGN_KEY_CHECKS=0; drop view $t; SET FOREIGN_KEY_CHECKS=1;"
done

exit 0;

