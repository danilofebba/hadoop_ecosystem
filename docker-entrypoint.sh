#!/bin/bash
sudo service ssh start
if [ ! -d "/data/hdfs/datanode/current" ]; then
    $HADOOP_HOME/bin/hdfs namenode -format
fi
start-all.sh
/bin/bash