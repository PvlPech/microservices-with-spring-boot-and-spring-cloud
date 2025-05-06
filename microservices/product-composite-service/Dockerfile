# Example of custom Java runtime using jlink in a multi-stage container build
FROM ghcr.io/graalvm/jdk-community:24 as builder
# instructions for exploding the fat-jar file into proper layers in the Docker image
WORKDIR /app
ADD ./target/*.jar app.jar
WORKDIR extracted
RUN java -Djarmode=tools -jar ../app.jar extract --layers --launcher
# Get all dependencies/modules into deps.info
WORKDIR /app
RUN jdeps --ignore-missing-deps -q  \
    --recursive  \
    --multi-release 24  \
    --print-module-deps  \
    --class-path 'extracted/app/dependencies/BOOT-INF/lib/*'  \
    app.jar > deps.info \
    && echo "$(cat deps.info),java.xml" > deps.info
# Print dependencies/modules from deps.info
RUN echo "Modules from jdeps:" && cat deps.info
# Create a custom Java runtime
RUN jlink --add-modules $(cat deps.info) \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

# Continue with your application deployment
FROM debian:buster-slim
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
COPY --from=builder /javaruntime $JAVA_HOME

WORKDIR app
COPY --from=builder app/extracted/app/dependencies/ ./
COPY --from=builder app/extracted/app/spring-boot-loader/ ./
COPY --from=builder app/extracted/app/snapshot-dependencies/ ./
COPY --from=builder app/extracted/app/application/ ./

EXPOSE 8080

ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]

