FROM node:alpine
WORKDIR /app/
COPY ./package.json .
RUN npm install
COPY . .
ENV PATH=$PATH:/app/node_modules/.bin
CMD [ "nodemon", "src/app.js" ]

# on va binder uniquement le dossier src, qui sera placé dans app. 
# la commande pour lancer le container devient :
##  docker build -t myapp .
##  docker run -p 8081:80 --mount type=bind,source="$(pwd)/src",target=/app/src myapp