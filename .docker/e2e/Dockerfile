FROM cypress/browsers:node-18.16.0-chrome-113.0.5672.92-1-ff-113.0-edge-113.0.1774.35-1
ADD e2etest /e2e

WORKDIR /e2e
RUN npm ci

#possibili problemi in accesso ai file
RUN chmod 777 /e2e
RUN chmod -R 777 /e2e

ENTRYPOINT ["/bin/sh"]
