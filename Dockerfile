FROM node:16.15.0 AS development

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install glob rimraf

RUN npm install --only=development

COPY . .

EXPOSE 3000

RUN npm run build

FROM node:16.15.0 as production

ARG NODE_ENV=production

ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=production

COPY . .

COPY --from=development /usr/src/app/ ./app

EXPOSE 3000

CMD [ "npm", "run", "start" ]
