#!/bin/bash

service ssh start
$HADOOP_HOME/bin/hdfs namenode -format
start-all.sh

bash
