FROM openjdk:8-jdk

ENV LOGICAL_DOWNLOAD_URL="https://downloads.sourceforge.net/project/logicaldoc/distribution/LogicalDOC%20CE%208.0/logicaldoc-8.0-tomcat-bundle.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flogicaldoc%2Ffiles%2Fdistribution%2FLogicalDOC%2520CE%25208.0%2Flogicaldoc-8.0-tomcat-bundle.zip%2Fdownload&ts=1537651009"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y --no-install-recommends && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    curl \
    unzip \
    imagemagick \
    ghostscript \
    python-jinja2 \
    python-pip \
    mysql-client \
    postgresql-client \
    vim \
    nano \
    sed \
    zip \
    wget \
    openssl \
    xpdf \
    ftp \
    sendmail-bin \
    sendmail \
    clamav \
    zlib1g-dev \
    libjpeg-dev \
    libgif-dev  \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libncurses5-dev \
    giflib-tools \
    libfreetype6 \
    gcc \
    build-essential \
    make \
    psmisc \
    libreoffice

ADD $LOGICAL_DOWNLOAD_URL /root/logicaldoc.zip
COPY unzip-strip.sh /root/unzip-strip.sh
RUN mkdir -p /opt/logicaldoc && \
    /root/unzip-strip.sh /root/logicaldoc.zip /opt/logicaldoc && \
    chmod +x /opt/logicaldoc/tomcat/bin/* && \
    pip install j2cli && \
    rm -rf /opt/logicaldoc/tomcat/webapps/ROOT && \
    mv /opt/logicaldoc/tomcat/webapps/logicaldoc.war /opt/logicaldoc/tomcat/webapps/ROOT.war

WORKDIR /opt/logicaldoc/tomcat
EXPOSE 8080
ENTRYPOINT ./bin/catalina.sh run
