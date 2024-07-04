# mobile/Dockerfile
FROM cirrusci/flutter:latest

WORKDIR /app

COPY pubspec.* ./
RUN flutter pub get

COPY . .

RUN flutter build web

CMD ["flutter", "run", "-d", "chrome"]
