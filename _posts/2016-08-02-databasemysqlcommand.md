---
layout: post
title: "Database MySQL Diagnosis"
date: 2016-08-02 12:25:06
description: MySQL Tools Commands
tags: 
 - database
---

**MySQL Backup and restore:**
backup:
innobackupex --defaults-file=/etc/my.cnf --parallel=4 --slave-info --rsync --user=user --password=aaa --tmpdir=$backup_dir --no-timestamp $backup_dir/$date
restore:
innobackupex --defaults-file=/etc/my.cnf --use-memory=1G --apply-log --tmpdir=$backup_dir $backup_dir/$date   

**MySQL QPS Monitor:**

    mysqladmin -P3306 -uroot -p -h127.0.0.1 -r -i 1 ext |\
    awk -F"|" \
    "BEGIN{ count=0; }"\
    '{ if(\$2 ~ /Variable_name/ && ((++count)%20 == 1)){\
        print "----------|---------|--- MySQL Command Status --|----- Innodb row operation ----|-- Buffer Pool Read --";\
        print "---Time---|---QPS---|select insert update delete|  read inserted updated deleted|   logical    physical";\
    }\
    else if (\$2 ~ /Queries/){queries=\$3;}\
    else if (\$2 ~ /Com_select /){com_select=\$3;}\
    else if (\$2 ~ /Com_insert /){com_insert=\$3;}\
    else if (\$2 ~ /Com_update /){com_update=\$3;}\
    else if (\$2 ~ /Com_delete /){com_delete=\$3;}\
    else if (\$2 ~ /Innodb_rows_read/){innodb_rows_read=\$3;}\
    else if (\$2 ~ /Innodb_rows_deleted/){innodb_rows_deleted=\$3;}\
    else if (\$2 ~ /Innodb_rows_inserted/){innodb_rows_inserted=\$3;}\
    else if (\$2 ~ /Innodb_rows_updated/){innodb_rows_updated=\$3;}\
    else if (\$2 ~ /Innodb_buffer_pool_read_requests/){innodb_lor=\$3;}\
    else if (\$2 ~ /Innodb_buffer_pool_reads/){innodb_phr=\$3;}\
    else if (\$2 ~ /Uptime / && count >= 2){\
      printf(" %s |%9d",strftime("%H:%M:%S"),queries);\
      printf("|%6d %6d %6d %6d",com_select,com_insert,com_update,com_delete);\
      printf("|%6d %8d %7d %7d",innodb_rows_read,innodb_rows_inserted,innodb_rows_updated,innodb_rows_deleted);\
      printf("|%10d %11d\n",innodb_lor,innodb_phr);\
    }}'


**MySQL Index Query**

    SELECT table_name AS Table, index_name AS Index, GROUP_CONCAT(column_name ORDER BY seq_in_index) AS Columns FROM information_schema.statistics WHERE table_schema = 'sakila' GROUP BY 1,2;

**MySQL Binary Log(output is dml commands stats)**

    mysqlbinlog --base64-output=DECODE-ROWS --verbose --verbose mysql-bin.000001 | grep -i -e "^### update" -e "^### insert" -e "^### delete" -e "^### replace" |tr '[A-Z]' '[a-z]' | tr -d '\`' | tr -d '###' | sed 's/insert into/insert/g' |sed -E "s/[0-9]{8}//g" | sort | uniq -c | sort -nr >mysql-bin.000001.stats
