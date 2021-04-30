ARG ARCH=
ARG BASE_TAG=2
ARG BASE_IMAGE=public.ecr.aws/amazonlinux/amazonlinux:${BASE_TAG}${ARCH}

FROM $BASE_IMAGE

RUN yum upgrade -y;\
    yum install -y \
    https://corretto.aws/downloads/latest/amazon-corretto-11-x64-al2-jre.rpm    ;\
    find /var/tmp -name "*.rpm" -print -delete  ;\
    find /tmp -name "*.rpm" -print -delete  ;\
    yum clean all ;\
    rm -rfv /var/cache/yum ;\
    rpm -qa | grep java | grep corretto | grep -Po '(\d+.\d+.\d+)' | uniq

MAINTAINER john@ews-network.net
LABEL runtime=amazoncorretto
LABEL version=11

CMD ["java"]
