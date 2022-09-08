#FROM pudding/dlll-paas-base-image:php-8-apache-20220616-1816
FROM pudding/dlll-paas-base-image:php-7.4-apache-20220617-1837
#FROM qua.paas-admin.dlll.nccu.edu.tw/dlll/dlll-paas-starter-pudding:starter-fa7562e5

# ------------------
# Following configuration will be used within CI/CD for Kubernetes. Please keep them at the bottom of file.
# More information :https://github.com/pulipulichen/dlll-paas-starter/wiki/Application-Server

#COPY app/ /app/
USER root
EXPOSE 80
#ENV env1=a
#ENV env2=php
#WORKDIR /var/www/html/
RUN apt-get update && \
    apt-get install -y --no-install-recommends sendmail && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg --enable-gd
RUN docker-php-ext-install gd

RUN rm -rf /var/www/html
RUN mkdir -p /var/www/html

#detect DB 
#WORKDIR /var/www/
#COPY ./wait-for-it.sh /var/www/wait-for-it.sh
#RUN chmod +x wait-for-it.sh

#start senmail
RUN sed -i '/#!\/bin\/sh/aservice sendmail restart' /usr/local/bin/docker-php-entrypoint

#CMD ["apache2-foreground"]
CMD ["./wait-for-it.sh", "targetHost:port","--strict", "--", "apache2-foreground"]
#RUN echo "ok" >> /var/www/html/a.php

