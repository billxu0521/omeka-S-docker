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

RUN rm -rf /var/www/html
RUN mkdir -p /var/www/html

CMD ["apache2-foreground"]

#RUN echo "ok" >> /var/www/html/a.php

