# Use the official Tomcat image
FROM tomcat:9.0

# Set the working directory
WORKDIR /usr/local/tomcat

# Copy the WAR file to Tomcat's webapps directory
COPY target/library_new.war webapps/

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
