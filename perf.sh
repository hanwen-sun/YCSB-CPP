# !/bin/bash

./ycsb -load -db leveldb -P workloads/workloada -P leveldb/leveldb.properties -s&
pid=$(ps | grep "ycsb" | grep -v grep | awk '{print $1}')
echo "get pid $pid"

sudo perf record -a -e cpu-clock -p $pid -g -F 99
wait $pid
perf report > report.log

perf script -i perf.data > out.perf
../FlameGraph/stackcollapse-perf.pl out.perf > out.floded
../FlameGraph/flamegraph.pl out.floded > ycsb_load.svg

rm -rf perf.data* out.perf 
rm -rf /tmp/ycsb-leveldb