#!/bin/sh

# Process ----------------------------------------------------------------------
echo '' && echo `date` && echo 'SQL Restore Start' && echo ''

SQL_FILE_COUNT=1
while [ $SQL_FILE_COUNT -lt $SQL_FILE_NUM ]
do
	echo '' && echo ${SQL_FILE[$SQL_FILE_COUNT]} && echo ''
	SQL="${DUMP_DIR}/${SQL_FILE[$SQL_FILE_COUNT]}"
	mysql -h ${SERVER} -P 3306 -u root -p${RDS_PASS} < $SQL
	SQL_FILE_COUNT=`expr ${SQL_FILE_COUNT} + 1`
done

echo '' && echo 'SQL Restore End' && echo `date` && echo ''