FROM maven:3.6.2-jdk-8 as first-service1

# Copy local code to the container image.
WORKDIR /app
COPY /pom.xml .
COPY /src ./src

# Build a release artifact.
RUN mvn package -DskipTests


FROM adoptopenjdk/openjdk8:x86_64-alpine-jdk8u232-b09-slim

# Copy the jar to the production image from the builder stage.
COPY --from=first-service1 /app/target/first-service1-0.0.1*.jar /first-service1-0.0.1-SNAPSHOT.jar

CMD ["java","-jar","/first-service1-0.0.1-SNAPSHOT.jar"]
