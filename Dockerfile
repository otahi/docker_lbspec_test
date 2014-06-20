FROM otahi/vagrant_ssh

MAINTAINER otahi

RUN apt-get update
RUN apt-get install -y netcat curl ngrep nginx openssl ca-certificates supervisor
RUN apt-get clean

USER root

ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./dstnode.crt /etc/nginx/dstnode.crt
ADD ./dstnode.key /etc/nginx/dstnode.key
ADD ./dstnode.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
