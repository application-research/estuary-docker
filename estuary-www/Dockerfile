
FROM node:14
ARG ESTUARY_HOSTNAME
ARG ESTUARY_TOKEN
ARG TEMPLATE_HOSTNAME=https://api.estuary.tech
RUN apt-get update && apt-get install -y git
WORKDIR /usr/src/estuary-www
RUN git clone https://github.com/application-research/estuary-www . && \
    npm install && \
    sed -i "s|$TEMPLATE_HOSTNAME|$ESTUARY_HOSTNAME|g" /usr/src/estuary-www/common/constants.ts && \
    sed -i "s|ESTUARY_TOKEN|$ESTUARY_TOKEN|g" /usr/src/estuary-www/common/constants.ts && \
    npm run build
CMD npm run dev