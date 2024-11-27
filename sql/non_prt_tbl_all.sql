select current_database()||'.'||result.schema_nm||'.'||result.tb_nm
FROM (
          SELECT a.schemaname AS schema_nm, a.tb_nm, a.relkind, a.tb_Gb , a.tb_tot_Gb, Storage, reloptions
   FROM ( SELECT st.schemaname
   				, split_part(st.relname::text, '_1_prt_'::text, 1) AS tb_nm
   				, st.relname AS tb_pt_nm
   				, cl.relkind
                , round(sum(pg_relation_size(st.relid)) / 1024 /1024 /1024,2 ) AS tb_Gb
                , round(sum(pg_total_relation_size(st.relid)) / 1024 /1024 /1024,2) AS tb_tot_Gb
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
     AND cl.relstorage != 'x'
     GROUP BY 1,2,3,4,7,8
     ) a
     LEFT OUTER JOIN pg_partitions b
     on    a.schemaname = b.schemaname
     and   a.tb_pt_nm   = b.partitiontablename
     where (a.schemaname, a.tb_pt_nm ) not in (select schemaname, tablename from pg_partitions)
     and a.schemaname not in ('gp_toolkit', 'information_schema', 'pg_catalog' )
     and b.partitiontablename is NULL
     order by 5 desc
) as result
