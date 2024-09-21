FROM cirrusci/flutter:latest

WORKDIR /app

COPY . .

RUN sudo apt-get update && \
    sudo apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && \
    sudo apt-get install -y nodejs

RUN sudo npm install -g http-server

EXPOSE 8085

CMD ["http-server", "build/web", "-p", "8085", "-c-1", "--cors"]