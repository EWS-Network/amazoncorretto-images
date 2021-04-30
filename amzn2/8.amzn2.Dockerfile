ARG ARCH=
ARG BASE_TAG=2
ARG BASE_IMAGE=public.ecr.aws/amazonlinux/amazonlinux:${BASE_TAG}${ARCH}


FROM $BASE_IMAGE
RUN yum upgrade -y; yum install -y amazon-linux-extras; amazon-linux-extras enable corretto8        ;\
    yum install -y java-1.8.0-amazon-corretto                 		    	   		    ;\
    yum erase -y amazon-linux-extras; yum clean all; rm -rfv /var/cache/yum

MAINTAINER john@ews-network.net
LABEL runtime=amazoncorretto
LABEL version=8

CMD ["java"]
