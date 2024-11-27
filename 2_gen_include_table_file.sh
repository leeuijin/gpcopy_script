#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")

#TABLE_REPORT
psql -tf ./sql/non_prt_tbl_all.sql > ./include-table-file/non_prt_tbl_all
psql -tf ./sql/prt_tbl_all.sql > ./include-table-file/prt_tbl_all

echo 'none partitoned table count'
sed '$d' ./include-table-file/non_prt_tbl_all |wc -l

echo 'partitoned table count'
sed '$d' ./include-table-file/prt_tbl_all |wc -l

echo '##############################################'
echo '2.Generated gpcopy files...'
echo '##############################################'
ls -al ./include-table-file
