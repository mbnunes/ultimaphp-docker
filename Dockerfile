FROM php:7.3.2-cli-stretch

ENV MONGODB_HOST=mongo
ENV MONGODB_PORT=27017
ENV MONGODB_USER=user
ENV MONGODB_PASS=password
ENV UPHP_DB_NAME=ultimaphp

RUN apt-get update && apt-get -y install unzip libgmp-dev git mongo-tools
 
RUN ggID='1SsMQsIq_EhAbofKECYXkiKzSM0D63YE-' \
&& ggURL='https://drive.google.com/uc?export=download' \
&& filename="$(curl -sc /tmp/gcokie "${ggURL}&id=${ggID}" | grep -o '="uc-name.*</span>' | sed 's/.*">//;s/<.a> .*//')" \
&& getcode="$(awk '/_warning_/ {print $NF}' /tmp/gcokie)" \
&& curl -Lb /tmp/gcokie "${ggURL}&confirm=${getcode}&id=${ggID}" -o "/tmp/${filename}"

VOLUME [ "/UOLocation" ]

RUN unzip -o /tmp/Muls.zip -d /UOLocation
RUN rm -rf /tmp/Muls.zip

VOLUME [ "/UltimaPHP" ]

RUN git clone https://github.com/UltimaPHP/UltimaPHP.git

EXPOSE 2593
COPY entrypoint.sh ./entrypoint.sh

CMD [ "bash", "entrypoint.sh" ]