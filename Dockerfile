# Stage 1: Build the application

FROM maven:3.8.7-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy source code and build

COPY pom.xml .

COPY . /app

RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat

FROM tomcat:9.0-jdk17-temurin

# Remove default apps

RUN rm -rf /usr/local/tomcat/webapps/*

# Copy built WAR into Tomcat

COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/my-app.war

EXPOSE 8080

CMD
