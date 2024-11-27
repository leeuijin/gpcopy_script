#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")
CURR_PATH=`pwd -P`

#gpcopy non partitioned

echo '##############################################'
echo '      3.GPCOPY Running Non-partioned Tables   '
echo '##############################################'

gpcopy \
--source-host mdw --source-port 5432 --source-user gpadmin \
--dest-host mdw --dest-port 5433 --dest-user gpadmin \
--include-table-file $CURR_PATH/include-table-file/non_prt_tbl_all \
--truncate --jobs 8 --validate count --analyze > ./logs/gpcopy_non_prt_all.$TODAY

sleep 3
cat ./logs/gpcopy_non_prt_all.$TODAY |grep 'Finished copying table' |wc -l ;  echo 'tables gpcopy successed'
