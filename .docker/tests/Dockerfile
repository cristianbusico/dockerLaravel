FROM node:20-alpine

ADD test /home/node/app/test

WORKDIR /home/node/app/test
RUN echo "$HTTP_PROXY"
RUN echo "$HTTPS_PROXY"
RUN npm config set proxy "$HTTP_PROXY"
RUN npm config set https-proxy "$HTTP_PROXY"
RUN npm ci

#possibili problemi in accesso ai file
RUN chmod 777 /home/node/app/test
RUN chmod 777 /home/node/app/test/assets
RUN chmod -R 777 /home/node/app/test/assets

ENTRYPOINT ["/bin/sh"]