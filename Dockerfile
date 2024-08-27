FROM nginx:alpine
LABEL maintainer="noushadhasan95@gmail.com"

# Remove the default content
RUN rm -rf /usr/share/nginx/html/*

# Copy the website content to the Nginx document root
COPY oxer.zip /usr/share/nginx/html/
WORKDIR /usr/share/nginx/html

# Extract the contents of oxer.zip
RUN unzip oxer.zip && rm oxer.zip

# Copy the contents from the extracted directory to the document root
RUN cp -r /usr/share/nginx/html/oxer-html/* /usr/share/nginx/html/ && rm -r /usr/share/nginx/html/oxer-html

# Set the correct permissions
RUN chmod -R 755 /usr/share/nginx/html

# Expose the default HTTP port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

