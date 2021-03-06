# Stage 1
FROM node:10-alpine as builder

# Make another directory to build in
RUN mkdir -p /app 
WORKDIR /app

# Copy package.json into /app and then install to get dependencies.
COPY package.json /app
RUN npm install

# Add the app
COPY . /app
RUN npm run build --prod -- --base-href=''

# Stage 2
FROM nginx:1.17.1-alpine
COPY --from=builder /app/dist/P3Angular /usr/share/nginx/html
COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/default.conf
