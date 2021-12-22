#!/bin/bash
tag=$1
docker build -t george7522/heic2jpg:$tag -f Dockerfile . 
docker push george7522/heic2jpg:$tag