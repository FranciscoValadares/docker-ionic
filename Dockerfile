FROM alpine:edge

ENV IONIC_VERSION 6.12.3
ENV CAPACITOR_CORE_VERSION 2.4.5
ENV CAPACITOR_CLI_VERSION 2.4.5
ENV ANGULAR_CLI_VERSION 11.0.5
ENV FSEVENTS 2.3.1

# Create app directory
WORKDIR /myApp

COPY myApp .

RUN apk update && apk add wget --no-cache wget
RUN apk add --update --no-cache nodejs npm
RUN npm install -g @ionic/cli@${IONIC_VERSION}

RUN ionic integrations enable capacitor --quiet -- myApp io.ionic.starter

RUN npm i fsevents@${FSEVENTS} -f --save-optional
RUN npm i -g @capacitor/core@${CAPACITOR_CORE_VERSION}
RUN npm i -g @capacitor/cli@${CAPACITOR_CLI_VERSION}

RUN capacitor init myApp io.ionic.starter --web-dir www --npm-client npm

RUN npm i -g @angular/cli@${ANGULAR_CLI_VERSION}
RUN npm i -g @angular/compiler-cli@${ANGULAR_CLI_VERSION}
RUN npm i -g @angular-devkit/core@${ANGULAR_CLI_VERSION}

RUN npm i -g @angular-devkit/build-angular

RUN npm install
RUN npm audit fix


EXPOSE 8100
#CMD ["ionic", "serve" ]

ENTRYPOINT ["ng", "serve"]
CMD ["--host", "0.0.0.0", "--port", "4201"]


#* --no-cache é igual a:  rm -rf /var/lib/apt/lists/* && apt-get clean
#npm install -g @ionic/cli@6.12.3
#docker build -t valadares/ionic-docker .
#docker run -p 8100:8100 -d valadares/ionic-docker .
#docker run -it -p 8100:8100 valadares/ionic-docker
#docker run valadares/ionic-docker

