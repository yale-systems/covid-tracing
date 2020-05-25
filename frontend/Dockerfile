FROM node:10

WORKDIR /usr/src/app

# '*' is to copy both package.json and package-lock.json
COPY package*.json ./

RUN npm install -g @vue/cli && npm install && npm install node-sass && npm audit fix

# This is where the api key should be copied
#  I'm not yet sure how to do this

COPY . .

EXPOSE 8081
CMD ["npm", "run", "serve"]
