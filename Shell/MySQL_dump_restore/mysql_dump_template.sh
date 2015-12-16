#!/bin/sh

# Conf: Connect DB
SERVER[1]=""
# SERVER[2]=""
# SERVER[3]=""
# SERVER[4]=""

# Conf: Server Num = SERVER + 1
SV_NUM=2

# Conf: Server Name
SERVER_NAME[1]=""
# SERVER_NAME[2]=""
# SERVER_NAME[3]=""
# SERVER_NAME[4]=""

# Conf: DB PASS
RDS_PASS=""

# Conf: Dump table
TABLE[1]=""
# TABLE[2]=""
# TABLE[3]=""
# TABLE[4]=""
# TABLE[5]=""
# TABLE[6]=""
# TABLE[7]=""
# TABLE[8]=""
# TABLE[9]=""
# TABLE[10]=""
# TABLE[11]=""
# TABLE[12]=""
# TABLE[13]=""

# Conf: Table num = TABLE NUM + 1
TABLE_NUM=2

# Conf: No Change !
DATE=`date '+%Y%m%d_%H%M%S'`

# Read File: Common Process * No Chabge ! --------------------------------------
. common_process/mysql_dump.sh