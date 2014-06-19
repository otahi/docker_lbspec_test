FROM otahi/vagrant_ssh

MAINTAINER otahi

RUN apt-get update
RUN apt-get install -y netcat curl ngrep nginx openssl supervisor --no-install-recommends
RUN apt-get clean

USER root

ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./dstnode.crt /etc/nginx/dstnode.crt
ADD ./dstnode.key /etc/nginx/dstnode.key
RUN cat /etc/nginx/dstnode.crt >> /etc/ssl/certs/ca-certificates.crt
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
