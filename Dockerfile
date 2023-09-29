FROM node:18.4.0-alpine
ARG DEBIAN_FRONTEND=noninteractive

#Setup project
WORKDIR /app
COPY package.json ./

RUN npm install
copy . . 

EXPOSE 5000
CMD ["npm","run","start"]