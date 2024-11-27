      SELECT a.schemaname AS schema_nm, a.tb_nm as tb_root_nm, a.tb_pt_nm, b.partitionname, round(a.tb_kb/1024/1024,2) AS tb_Gb , round(a.tb_tot_kb/1024/1024,2) AS tb_tot_Gb, Storage, reloptions
   FROM ( SELECT st.schemaname
                , split_part(st.relname::text, '_1_prt_'::text, 1) AS tb_nm
                , st.relname AS tb_pt_nm
                , round(sum(pg_relation_size(st.relid)) / 1024::bigint::numeric) AS tb_kb
                , round(sum(pg_total_relation_size(st.relid)) / 1024 /1024 /1024,2) AS tb_tot_kb
                , CASE cl.RELSTORAGE
                       WHEN 'h' THEN          'heap'
                       WHEN 'a' THEN          'append only'
                       WHEN 'v' THEN          'none'
                       WHEN 'c' THEN          'append only columnar'
                       END AS Storage
                , cl.reloptions
           FROM pg_stat_all_tables st
      JOIN pg_class cl ON cl.oid = st.relid
     WHERE st.schemaname !~~ 'pg_temp%'::text AND st.schemaname <> 'pg_toast'::name AND cl.relkind <> 'i'::"char"
     GROUP BY 1,2,3,6,7
     ) a
      JOIN pg_partitions b
     on    a.schemaname = b.schemaname
     and   a.tb_pt_nm   = b.partitiontablename
     where (a.schemaname, a.tb_pt_nm ) not in (select schemaname, tablename from pg_partitions)
     AND a.schemaname not in ('gp_toolkit', 'information_schema', 'pg_catalog' )
     order by 4 desc
