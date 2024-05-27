# Stage 1: Build stage
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy only the POM file to cache dependencies
COPY pom.xml .

# Download dependencies. This layer will be cached if the POM hasn't changed
RUN mvn -B dependency:go-offline

# Copy the rest of the source code
COPY src src

# Build the Maven project
RUN mvn -B package

# Stage 2: Runtime stage
FROM openjdk:17-slim AS runtime

# Set the working directory inside the container
WORKDIR /app


# Copy the built JAR from the build stage
COPY --from=build /app/target/gs-maven-0.1.0.jar .


# Expose the port your application runs on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
