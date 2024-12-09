FROM dart:3.3 AS build

RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN apt-get update && apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

WORKDIR /app
COPY . .

RUN flutter pub get

RUN flutter build web --release

RUN sed -i 's|<base href="/">|<base href="/">|' /app/build/web/index.html

FROM dart:3.3

RUN apt-get update && apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

RUN npm install -g http-server

COPY --from=build /app/build/web /app/build/web

EXPOSE 8085

CMD ["http-server", "/app/build/web", "-p", "8085", "--cors"]