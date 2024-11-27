#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")
CURR_PATH=`pwd -P`

echo '##############################################'
echo '      4.GPCOPY Running Partioned Tables       '
echo '##############################################'
#gpcopy partitioned

gpcopy \
--source-host mdw --source-port 5432 --source-user gpadmin \
--dest-host mdw --dest-port 5433 --dest-user gpadmin \
--include-table-file $CURR_PATH/include-table-file/prt_tbl_all \
--truncate --jobs 8 --validate count --analyze > ./logs/gpcopy_prt_all.$TODAY

sleep 3
cat ./logs/gpcopy_prt_all.$TODAY |grep 'Finished copying table' |wc -l ;  echo 'tables gpcopy successed'
