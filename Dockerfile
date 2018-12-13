FROM openjdk:8-jdk

RUN apt-get update && apt-get -y install openssh-server rsync

RUN wget https://www-us.apache.org/dist/hadoop/common/stable/hadoop-2.9.2.tar.gz && \
    tar zxf hadoop-2.9.2.tar.gz && rm hadoop-2.9.2.tar.gz && mv hadoop-2.9.2 /hadoop

RUN echo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >> etc/hadoop/hadoop-env.sh

WORKDIR /hadoop

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

COPY etc/hadoop/core-site.xml  etc/hadoop/hdfs-site.xml etc/hadoop/

COPY ssh/config /root/.ssh/config
COPY docker-entrypoint.sh docker-entrypoint.sh
ENTRYPOINT ["./docker-entrypoint.sh"]

EXPOSE 50070 50470 8020 9000 50075 50475 50010 50020 50090

VOLUME /dfs/
