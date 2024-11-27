#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")

#work dir create
echo '##############################################'
echo '0.init'
echo '##############################################'

mkdir -p ./logs
mkdir -p ./report
mkdir -p ./include-table-file

rm ./logs/*
rm ./report/*
rm ./include-table-file/*
