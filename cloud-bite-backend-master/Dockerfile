FROM node:lts-alpine

WORKDIR /usr/src/app

ENV HOST 0.0.0.0

COPY . .

RUN npm ci

CMD [ "npm", "run", "start:dev" ]

EXPOSE 3000
