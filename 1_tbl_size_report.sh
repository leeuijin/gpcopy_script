#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")

#TABLE_REPORT
psql -f ./sql/rpt_non_prt_tbl_all.sql > ./report/rpt_non_prt_tbl_all.$TODAY
psql -f ./sql/rpt_prt_tbl_all.sql > ./report/rpt_prt_tbl_all.$TODAY

echo '##############################################'
echo '          1.Please Check Report Files ...     '
echo '##############################################'

ls -al ./report
