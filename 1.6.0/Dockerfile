FROM srdc/cassandra:3.10
MAINTAINER SRDC Corp. <technical@srdc.com.tr>

### Fetch spark
ENV SPARK_VERSION 1.6.0

RUN curl http://archive.apache.org/dist/spark/spark-1.6.0/spark-1.6.0-bin-hadoop2.6.tgz | tar -xz -C /opt
RUN cd /opt && ln -s ./spark-$SPARK_VERSION-bin-hadoop2.6 spark

ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME/bin:$PATH

### Bootstrap 
ADD bootstrap.sh /bootstrap.sh
RUN chown root:root /bootstrap.sh
RUN chmod +x /bootstrap.sh

EXPOSE 7077 8080
CMD ["/bootstrap.sh"]
