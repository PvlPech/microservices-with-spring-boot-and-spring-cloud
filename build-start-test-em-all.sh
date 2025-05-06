#!/usr/bin/env bash

./mvnw clean install && docker-compose build && sh ./test-em-all.sh start stop