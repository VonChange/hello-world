FROM registry.cn-hangzhou.aliyuncs.com/fromjp/centos-jdk:latest
COPY target/jarName /jarName
COPY init.sh /init.sh
RUN chmod 777 /init.sh
CMD ["/bin/bash","-c","/init.sh jarName"]