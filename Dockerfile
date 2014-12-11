FROM debian:jessie
MAINTAINER Helder Correia <me@heldercorreia.com>

RUN apt-get update \
    && apt-get install -y --no-install-recommends vsftpd db5.3-util \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/vsftpd/empty \
 && mkdir -p /etc/vsftpd \
 && mkdir -p /var/www \
 && mkdir -p /var/ftp \
 && chown -R www-data:www-data /var/www
 && cp /etc/vsftpd.conf /etc/vsftpd.orig

COPY vsftpd.conf /etc/
COPY vsftpd.virtual /etc/pam.d/
COPY scripts/* /

VOLUME ["/var/ftp"]
EXPOSE 21 20

ENTRYPOINT ["/init"]
CMD ["vsftpd"]
