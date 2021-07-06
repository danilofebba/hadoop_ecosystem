mvn archetype:generate -DgroupId=org.example -DartifactId=avro -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

./hadoop fs -copyFromLocal /home/danilo/Documents/warehouse hdfs://192.168.43.2:9000/



{
  "type": "file",
  "connection": "hdfs://192.168.43.2:9000",
  "workspaces": {
    "root": {
      "location": "/",
      "writable": true,
      "defaultInputFormat": null,
      "allowAccessOutsideWorkspace": false
    }
  },
  "formats": {
    "json": {
      "type": "parquet"
    }
  },
  "enabled": true
}

export HIVE_HOME=/home/danilo/Documents/apache-hive-2.3.9-bin
export PATH=$PATH:$HIVE_HOME/bin

export HADOOP_HOME=/home/danilo/Documents/hadoop-3.3.0
export PATH=$PATH:$HADOOP_HOME/bin