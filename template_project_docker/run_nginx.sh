#!/usr/bin/env bash

sleep 2
rm /etc/nginx/conf.d/*
cp /opt/template_project/template_project_docker/nginx/* /etc/nginx/conf.d/
mkdir -p /etc/nginx/ssl/
cp /opt/template_project/template_project_docker/nginx/ssl/* /etc/nginx/ssl/
nginx -g "daemon off;"