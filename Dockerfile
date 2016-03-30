FROM srdc/cassandra:3.3
MAINTAINER SRDC Ltd. <technical@srdc.com.tr>

#Fetch scala
ENV SCALA_VERSION 2.10.6

RUN apt-get update && apt-get install -y libjansi-java
RUN wget www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb
RUN dpkg -i scala-$SCALA_VERSION.deb
RUN rm scala-$SCALA_VERSION.deb

### Fetch spark
ENV SPARK_VERSION 1.6.0

RUN mkdir /spark
WORKDIR /spark
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-$SPARK_VERSION-bin-hadoop2.6.tgz
RUN tar xvfz spark-$SPARK_VERSION-bin-hadoop2.6.tgz
RUN mv spark-$SPARK_VERSION-bin-hadoop2.6 spark-$SPARK_VERSION
RUN rm spark-$SPARK_VERSION-bin-hadoop2.6.tgz

ENV SPARK_HOME /spark/spark-$SPARK_VERSION
ENV SPARK_WORKER_MEMORY 1g
ENV SPARK_DAEMON_MEMORY 1g

### Bootstrap 
ADD bootstrap.sh /bootstrap.sh

EXPOSE 7077 8080
CMD ["/bootstrap.sh"]