#!/bin/bash

docker build -t wcg -f `dirname $0`/dockerfile.multi .
docker run --rm -d --name small-wcg -p 80:8888 wcg
curl -s -H "Content-Type: application/json" -d '{"text":"ths is a really really really important thing this is"}' http://127.0.0.1/version


