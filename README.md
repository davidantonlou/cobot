<center><img src="images/cobot.png" width="100"></center>

## Cóbot


The Cóbot has integrations with:
 * Docker
 * Jenkins
 * Giphy
 * Elasticsearch (pending)
 * Logstash (pending)

## Running CóBot

You can start co locally by running:

HUBOT_GIPHY_API_KEY=<api_key> HUBOT_JENKINS_AUTH=<user>:<pass> HUBOT_JENKINS_URL=<jenkins_url> HUBOT_SLACK_TOKEN=<slack_token> ./bin/hubot --adapter slack

Then you can interact with co by typing `co help`.

## Configure Slack Adapter

Go to your Slack space, Manage Aplications and add a new Hubot application. Then you could get the token API.