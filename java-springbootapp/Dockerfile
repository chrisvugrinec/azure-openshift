FROM alpine
RUN apk --update add openjdk8-jre
EXPOSE 8080
COPY target/azure-mfa-springboot-1.0.jar /etc
CMD ["/usr/bin/java","-jar","/etc/azure-mfa-springboot-1.0.jar"]
