#!/bin/bash
if [ $SPARK_MODE = "master" ]
then
  $SPARK_HOME/sbin/start-master.sh 
elif [ $SPARK_MODE = "slave" ]
then
  $SPARK_HOME/sbin/start-slave.sh spark://spark-master:7077
else
   echo "Unrecognized spark run mode"
fi

/cassandra-entrypoint.sh cassandra -f &

/bin/bash
