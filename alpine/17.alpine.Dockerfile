ARG ARCH=
ARG BASE_TAG=3.12.4
ARG BASE_IMAGE=alpine:${BASE_TAG:-latest}${ARCH}

FROM $BASE_IMAGE
ADD https://apk.corretto.aws/amazoncorretto.rsa.pub /etc/apk/keys/amazoncorretto.rsa.pub
RUN echo "https://apk.corretto.aws/" >> /etc/apk/repositories ; apk update; apk add amazon-corretto-17

MAINTAINER john@ews-network.net
LABEL runtime=amazoncorretto
LABEL version=17

ENTRYPOINT ["java"]
