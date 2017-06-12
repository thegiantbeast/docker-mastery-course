FROM node:6-alpine

ENV PORT 3000

WORKDIR /opt/app

COPY app/ /opt/app/

RUN npm install

EXPOSE $PORT

CMD ["npm", "start"]