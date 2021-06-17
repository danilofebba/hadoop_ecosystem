FROM ubuntu:20.04

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y wget

RUN apt install -y openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

RUN apt install -y ssh
RUN ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN wget --quiet --output-document /tmp/hadoop-3.3.0.tar.gz https://ftp.unicamp.br/pub/apache/hadoop/common/stable/hadoop-3.3.0.tar.gz
RUN tar -zxvf /tmp/hadoop-3.3.0.tar.gz -C /opt
RUN mv /opt/hadoop-3.3.0 /opt/hadoop
RUN rm /tmp/hadoop-3.3.0.tar.gz

ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

RUN echo "export HDFS_NAMENODE_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
RUN echo "export HDFS_DATANODE_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
RUN echo "export HDFS_SECONDARYNAMENODE_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
RUN echo "export YARN_RESOURCEMANAGER_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
RUN echo "export YARN_NODEMANAGER_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

RUN mkdir -p /data/hdfs/namenode
RUN mkdir -p /data/hdfs/datanode
RUN mkdir -p /data/hdfs/tmp

COPY core-site.xml $HADOOP_HOME/etc/hadoop
COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop
COPY mapred-site.xml $HADOOP_HOME/etc/hadoop
COPY yarn-site.xml $HADOOP_HOME/etc/hadoop

EXPOSE 8088
EXPOSE 9000
EXPOSE 9864
EXPOSE 9870

COPY docker-entrypoint.sh $HADOOP_HOME/etc/hadoop
ENTRYPOINT ["/opt/hadoop/etc/hadoop/docker-entrypoint.sh"]