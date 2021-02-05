#Specify a base image
FROM node:alpine

#Specify a working directory
WORKDIR '/app'

#Copy the dependencies file
COPY package*.json ./

#Install dependencies
RUN npm install

#Copy remaining files
COPY . .

#Build the project for production
RUN npm run build

#Run Stage Start
FROM nginx:alpine

# expose port 80
EXPOSE 80

#Copy production build files from builder phase to nginx
COPY --from=0 /app/build /usr/share/nginx/html