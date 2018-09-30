FROM lsiobase/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="blog.auskai.win version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="auska"

GLIBC_VERSION=2.28-r0

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	wget	

wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
apk add --allow-untrusted glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk && \
apk del wget

# copy local files
COPY bin/ /rrshare
COPY root/ /

# ports and volumes
EXPOSE 3001 6714 30210
VOLUME /mnt
