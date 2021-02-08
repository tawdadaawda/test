#Specify a base image
FROM node:alpine

#Specify a working directory
WORKDIR '/app'

#Copy the dependencies file
COPY ./package.json /app/package.json
COPY ./package-lock.json /app/package-lock.json


#Install dependencies
RUN yarn install

#Copy remaining files
COPY . .

#Build the project for production
RUN yarn build

#Run Stage Start
FROM nginx:latest

# expose port 80
EXPOSE 80

COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=0 /app/build /usr/share/nginx/html
