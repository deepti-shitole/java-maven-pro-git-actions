# Use a base image with Java and Maven pre-installed
FROM maven:3.8.4-openjdk-17-slim    # a slim variant to reduce image size.

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files into the container
COPY . .

# Build the Maven project
RUN mvn -B package   # -B flag specifies non-interactive mode

# Expose the port your application runs on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "target/my-app-1.0-SNAPSHOT.jar"]



