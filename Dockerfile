FROM alpine:3.20.3

RUN apk add --no-cache openssl 

WORKDIR /opt/app

COPY ssl_check.sh .

RUN chmod +x ssl_check.sh

CMD ["./ssl_check.sh"]