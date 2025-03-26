# Use the official Tomcat image
FROM tomcat:9.0

# Set working directory
WORKDIR /usr/local/tomcat

# Remove default Tomcat webapps (optional)
RUN rm -rf webapps/*

# Copy the WAR file into Tomcat's webapps directory
COPY target/library_new.war webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
