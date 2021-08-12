FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    openssh-server \
    vim \
    wget \
    net-tools \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p \
    /data/hdfs/namenode \
    /data/hdfs/datanode \
    /data/hdfs/tmp \
    /data/hdfs/logs

RUN wget --quiet --output-document /tmp/hadoop-3.3.1.tar.gz https://ftp.unicamp.br/pub/apache/hadoop/common/stable/hadoop-3.3.1.tar.gz
RUN tar -zxvf /tmp/hadoop-3.3.1.tar.gz -C /opt
RUN mv /opt/hadoop-3.3.1 /opt/hadoop
RUN rm /tmp/hadoop-3.3.1.tar.gz
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /opt/hadoop/etc/hadoop/hadoop-env.sh

COPY core-site.xml /opt/hadoop/etc/hadoop
COPY hdfs-site.xml /opt/hadoop/etc/hadoop
COPY docker-entrypoint.sh /opt/hadoop/etc/hadoop

RUN addgroup hadoopgroup
RUN adduser --gecos '' --ingroup hadoopgroup --disabled-password hadoopuser
RUN echo "hadoopuser ALL=(ALL)   NOPASSWD:ALL" >> /etc/sudoers

RUN chown -R hadoopuser:hadoopgroup \
    /opt/hadoop \
    /data

USER hadoopuser

RUN ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/authorized_keys

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV HADOOP_LOG_DIR=/data/hdfs/logs

WORKDIR /home/hadoopuser

EXPOSE 8042 8088 9000 9864 9870 

ENTRYPOINT ["/opt/hadoop/etc/hadoop/docker-entrypoint.sh"]