#!/bin/bash
docker run --rm -d --name "static" -p 8081:80 -v `dirname $0`/sites/index.html:/var/www/html/static/index.html -e OUR_SITE='static' hometask-image


