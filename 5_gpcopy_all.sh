#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")
CURR_PATH=`pwd -P`

#gpcopy all jobs execute 

sh 0_gpcopy_init.sh
sh 1_tbl_size_report.sh
sh 2_gen_include_table_file.sh
sh 3_gpcopy_non_prt_all.sh
sh 4_gpcopy_prt_all.sh

