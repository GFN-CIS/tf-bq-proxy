#!/bin/bash
docker build . -t gfncis/tf-bq-proxy:latest
docker push gfncis/tf-bq-proxy:latest