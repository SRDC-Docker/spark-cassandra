FROM srdc/cassandra:3.3
MAINTAINER SRDC Ltd. <technical@srdc.com.tr>

#Install Scala
ENV SCALA_VERSION 2.10.6

RUN curl -sL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | gunzip | tar -x -C /usr/local
RUN cd /usr/local && ln -s ./scala-$SCALA_VERSION scala
ENV SCALA_HOME  /usr/local/scala
ENV PATH ${PATH}:${SCALA_HOME}/bin

### Fetch spark
ENV SPARK_VERSION 1.6.0

RUN curl http://ftp.itu.edu.tr/Mirror/Apache/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop2.6.tgz | tar -xz -C /opt
RUN cd /opt && ln -s ./spark-$SPARK_VERSION-bin-hadoop2.6 spark

ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME/bin:$PATH

### Bootstrap 
ADD bootstrap.sh /bootstrap.sh
RUN chown root:root /bootstrap.sh
RUN chmod +x /bootstrap.sh

EXPOSE 7077 8080
CMD ["/bootstrap.sh"]
