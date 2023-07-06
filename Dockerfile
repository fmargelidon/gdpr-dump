FROM alpine:latest

RUN apk --no-cache update && apk add --no-cache php php-phar php-mbstring php-pdo_mysql mysql-client postgresql-client

COPY build/dist/gdpr-dump.phar /gdpr-dump.phar
RUN chmod +x gdpr-dump.phar
