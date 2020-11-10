FROM lsiobase/alpine:3.12

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="blog.auskai.win version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="auska"

ENV GLIBC_VERSION=2.32-r0 TZ=Asia/Shanghai VER=2.20

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	wget \
	libstdc++ && \
 wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
 wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
 apk add --allow-untrusted glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk && \
 wget http://appdown.rrys.tv/rrshareweb_linux_${VER}.tar.gz && \
 tar xf rrshareweb_linux_${VER}.tar.gz -C / && \
 rm -f glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk rrshareweb_linux_${VER}.tar.gz && \
 apk del wget

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 3001 6714 30210
VOLUME /opt/work/rrshareweb/data
