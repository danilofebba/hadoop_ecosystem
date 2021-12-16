# Hadoop - Pseudo-Distributed Mode
Follow the steps below.
## Install Docker Engine and Docker Compose
- [Docker Engine](https://docs.docker.com/engine/install)
- [Docker Compose](https://docs.docker.com/engine/install)
## Install OpenJDK 8
``` bash
sudo apt install openjdk-8-jdk
vim ~/.bashrc
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin
```
## Configure DNS
``` bash
sudo vim /etc/hosts
192.168.43.2  dataserver
```
## Run the command lines below
``` bash
$ git clone https://github.com/danilofebba/hadoop_ecosystem
$ cd hadoop_ecosystemS
$ docker-compose up --build
```


# Hadoop - Command Lines
- ~/hadoop-3.3.1/bin/hdfs dfs -put ~/Documents/test.csv hdfs://dataserver:9000/warehouse/test.csv
