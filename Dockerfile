FROM alpine:latest

WORKDIR /root

RUN apk add --update nodejs curl npm
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
RUN gunzip elm.gz

RUN chmod +x elm
RUN cp /root/elm /usr/local/bin/elm
RUN addgroup -g 1000 -S elm
RUN adduser -h /home/elm -g "" -s /bin/sh -G elm -S -D -u 1000 elm

USER elm

RUN mkdir /home/elm/app

WORKDIR /home/elm/app

RUN npm config set prefix /home/elm/.local
RUN npm install --global elm-test

ENTRYPOINT [ "/home/elm/.local/bin/elm-test" ]

CMD [ "--version" ]
