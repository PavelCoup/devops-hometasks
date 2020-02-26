FROM debian
LABEL maintainer="jeffmshale@gmail.com"
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get upgrade \
&& echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
&& apt-get install -y apt-utils php apache2 \
&& rm /var/www/html/index.html \
&& chmod -R 777 /var/run/apache2
COPY ./sites/index.php /var/www/html/index.php
COPY ./entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT /tmp/entrypoint.sh
