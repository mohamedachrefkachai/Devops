# ===== STAGE 1 : build =====
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copier uniquement le pom pour activer le cache
COPY pom.xml .
RUN mvn dependency:go-offline

# Copier le code source
COPY src ./src
RUN mvn clean package -DskipTests

# ===== STAGE 2 : runtime (léger) =====
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copier uniquement le JAR final
COPY --from=build /app/target/*.jar app.jar

# Sécurité (optionnelle mais pro)
RUN addgroup -S app && adduser -S app -G app
USER app

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
