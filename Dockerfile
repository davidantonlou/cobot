FROM node:latest

LABEL Author="David Antón <davidantonlou@gmail.com>"

ENV HUBOT_JENKINS_URL \
    HUBOT_JENKINS_AUTH \
    HUBOT_SLACK_TOKEN

RUN npm install -g docker
RUN npm install -g hubot 
RUN npm uninstall coffeescript
RUN npm install -g coffee-script@1.11.1
RUN npm uninstall hubot-heroku-keepalive --save

EXPOSE 80

RUN export HUBOT_JENKINS_URL=${HUBOT_JENKINS_URL}
RUN export HUBOT_JENKINS_AUTH=${HUBOT_JENKINS_AUTH}
RUN export HUBOT_SLACK_TOKEN=${HUBOT_SLACK_TOKEN}

RUN mkdir /data && mkdir /data/app
RUN cd /data/app && npm install

WORKDIR /data/app

CMD ["bin/hubot", "--adapter", "slack"]