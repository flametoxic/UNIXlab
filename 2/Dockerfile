FROM alpine:latest

RUN apk add --no-cache coreutils

WORKDIR /app

COPY script.sh /app/script.sh
RUN chmod +x /app/script.sh

CMD ["sh", "script.sh"]