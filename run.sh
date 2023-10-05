# !/bin/bash

cd ~/storage/leveldb/build
make install
cd ~/storage/YCSB-cpp

rm -rf /tmp/ycsb-leveldb/
make clean
make
make BIND_LEVELDB=1

#./ycsb -load -db leveldb -P workloads/workloada -P leveldb/leveldb.properties -s > result_a.txt
#./ycsb -run -db leveldb -P workloads/workloada -P leveldb/leveldb.properties -s >> result_a.txt

#rm -rf /tmp/ycsb-leveldb/

workload="workload"
result="result_30w"

for i in {a..f}
do
  rm -rf /tmp/ycsb-leveldb/
  tmp_workload=$workload$i
  tmp_result=$result$i
  ./ycsb -load -db leveldb -P workloads/$tmp_workload -P leveldb/leveldb.properties -s > analyze/$tmp_result.txt
  ./ycsb -run -db leveldb -P workloads/$tmp_workload -P leveldb/leveldb.properties -s >> analyze/$tmp_result.txt
done

'''
cd ~/storage/2Qleveldb/build
make install
cd ~/storage/YCSB-cpp

rm -rf /tmp/ycsb-leveldb/
make clean
make
make BIND_LEVELDB=1

workload="workload"
result="2Qresult_0.05_30w"

for i in {a..f}
do
  rm -rf /tmp/ycsb-leveldb/
  tmp_workload=$workload$i
  tmp_result=$result$i
  ./ycsb -load -db leveldb -P workloads/$tmp_workload -P leveldb/leveldb.properties -s > analyze/$tmp_result.txt
  ./ycsb -run -db leveldb -P workloads/$tmp_workload -P leveldb/leveldb.properties -s >> analyze/$tmp_result.txt
done
'''