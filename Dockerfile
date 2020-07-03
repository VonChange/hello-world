FROM registry.cn-hangzhou.aliyuncs.com/fromjp/centos-jdk:latest
COPY target/app.jar /app.jar
ENTRYPOINT exec java  -jar /app.jar
