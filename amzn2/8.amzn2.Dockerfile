ARG ARCH=
ARG BASE_TAG=2
ARG BASE_IMAGE=public.ecr.aws/amazonlinux/amazonlinux:${BASE_TAG}${ARCH}

FROM $BASE_IMAGE as certbuild
ADD https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem /etc/ssl/certs/
RUN yum install openssl -y;\
     openssl x509 -outform der -in /etc/ssl/certs/rds-combined-ca-bundle.pem \
     -out /etc/ssl/certs/rds-combined-ca-bundle.der

FROM $BASE_IMAGE
ADD https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem /etc/ssl/certs/
RUN yum upgrade -y; yum install -y amazon-linux-extras; amazon-linux-extras enable corretto8        ;\
    yum install -y java-1.8.0-amazon-corretto                 		    	   		    ;\
    yum erase -y amazon-linux-extras;\
    yum autoremove -y; \
    yum clean packages; yum clean headers; yum clean metadata; yum clean all; rm -rfv /var/cache/yum ;\
    rpm -qa | grep java | grep corretto | grep -Po '(\d+.\d+.\d+)' | uniq

ADD https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem /etc/ssl/certs/
COPY --from=certbuild /etc/ssl/certs/rds-combined-ca-bundle.der /etc/ssl/certs/rds-combined-ca-bundle.der
RUN keytool -importcert -file /etc/ssl/certs/rds-combined-ca-bundle.pem \
    -keystore cacerts -storepass changeit -trustcacerts -noprompt

LABEL runtime=amazoncorretto
LABEL version=8

CMD ["java"]
