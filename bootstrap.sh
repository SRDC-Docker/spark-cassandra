#!/bin/bash
set -e

if [[ -z "$SPARK_MODE" ]]; then
    export SPARK_MODE="master"
fi

if [ "$SPARK_MODE" = "master" ]; then
  if [[ -z "$CASSANDRA_LISTEN_ADDRESS" ]]; then
     export CASSANDRA_LISTEN_ADDRESS="auto"
  fi     
 	
  echo "Starting Spark master..."

  $SPARK_HOME/sbin/start-master.sh && $SPARK_HOME/sbin/start-slave.sh $SPARK_MASTER_URL && /cassandra-entrypoint.sh cassandra -f  

  echo "Cassandra and Spark started ...."

elif [ "$SPARK_MODE" = "slave" ]; then
  if [[ -z "$SPARK_MASTER_URL" ]]; then
     echo "Enviornment variable SPARK_MASTER_URL is missing !!!"
     exit  	  
  fi
  
  if [[ -z "$CASSANDRA_SEEDS" ]]; then
     echo "Enviornment variable CASSANDRA_SEEDS is missing!!!"
     exit
  fi

  echo "Starting Spark slave..."

  $SPARK_HOME/sbin/start-slave.sh $SPARK_MASTER_URL && /cassandra-entrypoint.sh cassandra -f

  echo "Cassandra and Spark started ...."
else
   echo "Unrecognized spark run mode, use either 'master' or 'slave'"
fi

