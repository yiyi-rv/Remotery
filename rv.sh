#!/bin/bash
set -x

json_out=`pwd`/errors.json
report_out=`pwd`/report

sed -i 's/\.\.\\lib\\Remotery.h/\.\.\/lib\/Remotery.h/g' sample/sample.c 
kcc -profile x86_64-linux-gcc-glibc-gnuc
kcc -std=gnu11 lib/Remotery.c sample/sample.c -I ./lib -pthread -lm
timeout 5s ./a.out

touch $json_out && rv-html-report $json_out -o $report_out
rv-upload-report $report_out
