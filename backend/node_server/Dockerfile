FROM node:15.10.0

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .
RUN npx prisma generate

CMD ["node", "index.js"]