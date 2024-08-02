FROM node:20-bookworm

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV NODE_PATH=./build
# Set the npm omission to --omit=dev unless overwritten by a docker-compose build arg
ARG NPM_OMIT="--omit=dev"
ENV NPM_OMIT ${NPM_OMIT}

# Install and upgrade base OS dependencies.
RUN apt-get update
RUN apt-get upgrade -y

RUN npm install -g npm@latest
RUN npm install -g typescript@latest

# Mount the network share (mdlabs.local/share) to the container with mount-cifs with read and write permissions
RUN apt-get install -y cifs-utils
#RUN mkdir -p /mnt/reqs
#RUN mkdir -p /mnt/utilities
#RUN mkdir -p /mnt/accessioning

COPY package*.json .

RUN ["sh","-c","npm ci --verbose $NPM_OMIT"]

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["sh", "-c", "npm run start"]