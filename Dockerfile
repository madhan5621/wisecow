FROM ubuntu:22.04
RUN apt-get update && apt-get install -y cowsay fortune-mod netcat-openbsd dos2unix
ENV PATH="/usr/games:${PATH}"
WORKDIR /app
COPY wisecow.sh .
RUN dos2unix wisecow.sh
RUN chmod +x wisecow.sh
EXPOSE 4499
ENTRYPOINT ["./wisecow.sh"]