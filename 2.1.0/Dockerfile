FROM srdc/cassandra:3.10
MAINTAINER SRDC Corp. <technical@srdc.com.tr>

### Fetch spark
ENV SPARK_VERSION 2.1.0

RUN curl http://ftp.itu.edu.tr/Mirror/Apache/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop2.7.tgz | tar -xz -C /opt
RUN cd /opt && ln -s ./spark-$SPARK_VERSION-bin-hadoop2.7 spark

ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME/bin:$PATH

### Bootstrap 
COPY bootstrap.sh /bootstrap.sh
RUN chown root:root /bootstrap.sh
RUN chmod +x /bootstrap.sh

EXPOSE 7077 8080
CMD ["/bootstrap.sh"]
