# Use a base image with Java and curl installed
FROM openjdk:17-jdk-slim

# Set environment variables
ENV MAVEN_VERSION=3.8.4
ENV MAVEN_HOME=/opt/maven

# Download and install Maven
RUN mkdir -p $MAVEN_HOME && \
    curl -fsSL -o maven.tar.gz https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar -xzf maven.tar.gz -C $MAVEN_HOME --strip-components=1 && \
    rm maven.tar.gz

# Add Maven to PATH
ENV PATH=$MAVEN_HOME/bin:$PATH

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files into the container
COPY . /app

# Build the Maven project
RUN mvn -B package

# Expose the port your application runs on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "target/my-app-1.0-SNAPSHOT.jar"]
