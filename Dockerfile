FROM gradle:jdk8 AS build
WORKDIR /home/gradle/src
COPY --chown=gradle:gradle . /home/gradle/src
RUN ./gradlew installDist

FROM eclipse-temurin:8-jre
EXPOSE 8080
WORKDIR /app
COPY --from=build /home/gradle/src/build/install/src/ /app/
COPY --from=build /home/gradle/src/fauceth.properties.example /app/
ENTRYPOINT ["/app/bin/src"]
