FROM node:20-bookworm as base

WORKDIR /home/node/app

ENV NODE_PATH=./build

# Set the default command to run when the container starts, unless overwritten by a docker-compose build arg
ARG NPM_COMMAND=start
ENV NPM_COMMAND ${NPM_COMMAND}
# Set the npm omission to --omit=dev unless overwritten by a docker-compose build arg
ARG NPM_OMIT="--omit=dev"
ENV NPM_OMIT ${NPM_OMIT}

COPY package*.json .

RUN ["sh","-c","npm ci --verbose $NPM_OMIT"]

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["sh", "-c", "npm run $NPM_COMMAND"]