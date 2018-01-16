FROM frolvlad/alpine-oraclejdk8:slim
LABEL version="1.0"
LABEL maintainer="Mcdostone"

WORKDIR /opt
USER root

ENV HADOOP_VERSION 2.9.0
ENV HADOOP_HOME /opt/hadoop-${HADOOP_VERSION}
ENV HADOOP_OPTS "$HADOOP_OPTS -XX:-PrintWarnings -Djava.net.preferIPv4Stack=true"
ENV HADOOP_PREFIX ${HADOOP_HOME}
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

RUN set -ex; \
    apk add --update --no-cache openssl bash openssh openrc rsync procps curl tar; \
    curl http://www.eu.apache.org/dist/hadoop/common/stable/hadoop-${HADOOP_VERSION}.tar.gz | tar xz

ADD ./conf/*.xml ${HADOOP_HOME}/etc/hadoop/

RUN ssh-keygen -q -N '' -t dsa -f /etc/ssh/ssh_host_dsa_key; \
    ssh-keygen -q -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key; \
    ssh-keygen -qP '' -f /root/.ssh/id_rsa; \
    echo -e "Host * \n UserKnownHostsFile /dev/null \n StrictHostKeyChecking no \n" > /root/.ssh/config; \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys; \
    ssh-keygen -A; \
    chmod 600 /root/.ssh/config; \
    chown root:root /root/.ssh/config; \
    sed -i "s#\${JAVA_HOME}#$JAVA_HOME#g" ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh; \
    ${HADOOP_HOME}/bin/hdfs namenode -format; \
    chmod -R 755 /opt/hdfs

# HDFS ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 10020 19888
# Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
# Other ports
EXPOSE 49707 2122

CMD /usr/sbin/sshd && ${HADOOP_HOME}/sbin/start-dfs.sh && bash