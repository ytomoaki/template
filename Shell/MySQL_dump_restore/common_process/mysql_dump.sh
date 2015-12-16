#!/bin/sh

# Common Process ---------------------------------------------------------------

SV_COUNT=1
while [ $SV_COUNT -lt $SV_NUM ]
do
	# make dir
	DIR_PATH="${DATE}_${SERVER_NAME[${SV_COUNT}]}"
	mkdir ${DIR_PATH}
	cd ${DIR_PATH}

	# mysql dump
	COUNT=1
	while [ $COUNT -lt $TABLE_NUM ]
	do
		# Echo Message
		echo '' && echo "Dump start: ${DATE} ${SERVER_NAME[${SV_COUNT}]} ${TABLE[${COUNT}]}" && echo ''
		# File Name Setting
		SQL_FILE="sql_dump-${SERVER_NAME[${SV_COUNT}]}-${TABLE[${COUNT}]}-${DATE}.sql"
		# Dump
		mysqldump -h ${SERVER[${SV_COUNT}]} -P 3306 -u root -p${RDS_PASS} -B ${TABLE[${COUNT}]} > ${SQL_FILE}
		# CountUp
    	COUNT=`expr ${COUNT} + 1`
	done

	# CountUp
	SV_COUNT=`expr ${SV_COUNT} + 1`
	
	# Directory Change
	cd ..
done