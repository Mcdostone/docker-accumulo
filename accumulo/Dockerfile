FROM mcdostone/hadoop
LABEL version="1.0"
LABEL maintainer="Mcdostone"

WORKDIR /opt

ENV ACCUMULO_VERSION 1.8.1
ENV ACCUMULO_MEM 3GB
ENV ZOOKEEPER_VERSION 3.4.11
ENV INSTANCE accumulo
ENV ACCUMULO_PASSWORD root
ENV ACCUMULO_DEFAULT_TABLE my_table
ENV ACCUMULO_HOME /opt/accumulo-${ACCUMULO_VERSION}
ENV ZOOKEEPER_HOME /opt/zookeeper-${ZOOKEEPER_VERSION}
ENV PATH $PATH:$ACCUMULO_HOME/bin:$ZOOKEEPER_HOME/bin

RUN apk add --update --no-cache bash git python python-dev py-pip build-base; \
    apk add --update --no-cache bash-completion; \
    curl http://apache.crihan.fr/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz | tar xz; \
    curl http://apache.crihan.fr/dist/accumulo/${ACCUMULO_VERSION}/accumulo-${ACCUMULO_VERSION}-bin.tar.gz | tar xz; \
    sed -i 's?mktemp -d /tmp/accumulo-native.XXXX?mktemp -d /tmp/accumulo-native.XXXXXX?g' ${ACCUMULO_HOME}/bin/build_native_library.sh; \
    ${ACCUMULO_HOME}/bin/build_native_library.sh; \
    cp ${ACCUMULO_HOME}/conf/examples/${ACCUMULO_MEM}/standalone/* ${ACCUMULO_HOME}/conf; \
    echo -e "\nexport ACCUMULO_MONITOR_BIND_ALL=\"true\"" >> ${ACCUMULO_HOME}/conf/accumulo-env.sh; \
    cp ${ZOOKEEPER_HOME}/conf/zoo_sample.cfg ${ZOOKEEPER_HOME}/conf/zoo.cfg; \
    ln -s ${ACCUMULO_HOME}/bin/start-all.sh /usr/bin/accumulo-start-all-sh

ADD ./scripts/entrypoint.sh /usr/bin/
ADD ./scripts/reminder.sh /usr/bin/
ADD ./scripts/.bashrc /root/
RUN chmod +x /usr/bin/accumulo-start-all-sh; \
    chmod +x /usr/bin/entrypoint.sh; \
    chmod +x /usr/bin/reminder.sh

EXPOSE 42424

CMD [ "/usr/bin/entrypoint.sh" ]