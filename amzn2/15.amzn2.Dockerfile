ARG ARCH=
ARG BASE_TAG=2.0.20210219.0
ARG BASE_IMAGE=public.ecr.aws/amazonlinux/amazonlinux:${BASE_TAG}${ARCH}

FROM $BASE_IMAGE

RUN yum upgrade -y;\
    yum install -y \
    https://corretto.aws/downloads/latest/amazon-corretto-15-x64-linux-jdk.rpm ;\
    find /var/tmp -name "*.rpm" -print -delete				       ;\
    find /tmp -name "*.rpm" -print -delete				       ;\
    yum clean all							       ;\
    rm -rfv /var/cache/yum						       ;\
    rpm -qa | grep java | grep corretto | grep -Po '(\d+.\d+.\d+)' | uniq

MAINTAINER john@ews-network.net
LABEL runtime=amazoncorretto
LABEL version=15

CMD ["java"]
