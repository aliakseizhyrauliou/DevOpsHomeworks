FROM ubuntu:20.04


RUN apt-get update && \
    apt-get install curl -y && \
    apt-get install nginx -y && \
    mkdir -p /app/static

COPY nginx/nginx.conf /etc/nginx/sites-available/default

COPY static /app/static

EXPOSE 8080

CMD ["nginx", "-g", "daemon off"]
