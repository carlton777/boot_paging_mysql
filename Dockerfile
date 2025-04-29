# 빌드 단계
FROM gradle:8.3.0-jdk17 AS builder
WORKDIR /app
COPY --chown=gradle:gradle . .
RUN gradle build -x test

# 실행 단계
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
ENV PORT=8080
ENTRYPOINT ["java", "-jar", "app.jar"]
