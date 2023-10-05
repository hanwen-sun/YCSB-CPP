# !/bin/bash
workload="workload"
workload+=$1 

#iotop -b -o -d 1 > iotop.log &
./ycsb -run -db leveldb -P workloads/$workload -P leveldb/leveldb.properties -s&
pid=$(ps | grep "ycsb" | grep -v grep | awk '{print $1}')
echo "get pid $pid"

iotop -b -ok -d 0.2 -p $pid  > iotop.log &
#iotop -bok -d 0.2 > iotop.log&
pid_io=$(ps | grep "iotop" | grep -v grep | awk '{print $1}')
echo "get pid_io $pid_io"

wait $pid


total_write=0
total_read=0
#disk_write=$(cat iotop.log | grep "Current DISK WRITE:" | awk '{print $10}')
total_write=$(cat iotop.log | grep "Current DISK WRITE:" | awk '{disk_write+=(($10/5))/1024 }END{print disk_write}')
total_read=$(cat iotop.log | grep -a "Current DISK READ:" | awk '{disk_read+=(($4/5))/1024 }END{print disk_read}')

#total_write=$total_write/1024
#total_read=$total_read/1024
#total_write=`expr $total_write / 1024`
#total_read=`expr $total_read / 1024`

#awk 'BEGIN{printf "load total write: %.2f\n",'$total_write'/1024}'
#awk 'BEGIN{printf "load total read:%.2f\n",'$total_read:'/1024}'

echo "load total_write: $total_write"
#echo "$total_write / 1024"| bc

echo "load total_read:  $total_read"
#echo "$total_read / 1024"| bc


kill -9 $pid_io
#rm -rf iotop.log