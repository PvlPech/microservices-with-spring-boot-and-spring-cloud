#!/bin/sh

mkdir microservices
cd microservices

spring init \
--boot-version=3.4.5 \
--java-version=24 \
--build=maven \
--packaging=jar \
--name=product-service \
--package-name=org.pvlpech.microservices.core.product \
--groupId=org.pvlpech.microservices.core.product \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
product-service

spring init \
--boot-version=3.4.5 \
--java-version=24 \
--build=maven \
--packaging=jar \
--name=review-service \
--package-name=org.pvlpech.microservices.core.review \
--groupId=org.pvlpech.microservices.core.review \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
review-service

spring init \
--boot-version=3.4.5 \
--java-version=24 \
--build=maven \
--packaging=jar \
--name=recommendation-service \
--package-name=org.pvlpech.microservices.core.recommendation \
--groupId=org.pvlpech.microservices.core.recommendation \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
recommendation-service

spring init \
--boot-version=3.4.5 \
--java-version=24 \
--build=maven \
--packaging=jar \
--name=product-composite-service \
--package-name=org.pvlpech.microservices.composite.product \
--groupId=org.pvlpech.microservices.composite.product \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
product-composite-service

cd ..