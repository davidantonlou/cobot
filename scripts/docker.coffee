# Description:
#   Script for execute Docker commands from Hubot
#
# Commands:
#   co docker ps
#   co docker images
#   co docker stop <containerId>
#   co docker rmi <imageId>
#   co docker rm <containerId>
#   co docker bash <containerId>
#   co docker inspect <containerId>
#   co docker network inspect <networkId>
#   co docker network ls
#   co docker prune 
#
# Author:
#   David Antón <davidantonlou@gmail.com>
#

run_cmd = (cmd, cb ) ->
    exec = require("child_process").exec
    child = exec cmd, (error, stdout, stderr) ->
    child.stdout.on "data", (buffer) -> cb buffer.toString()
    child.stderr.on "data", (buffer) -> cb buffer.toString()

module.exports = (robot) ->
  robot.respond /docker ps$/i, (msg) ->
    run_cmd 'docker ps -a', (text) -> msg.send text

  robot.respond /docker images$/i, (msg) ->
    run_cmd 'docker images', (text) -> msg.send text

  robot.respond /docker stop (.*)/i, (msg) ->
    msg.send "Stopping container " + msg.match[1].replace(/[\W]+/g, "") + "..."
    run_cmd 'docker stop ' + msg.match[1].replace(/[\W]+/g, ""), (text) -> msg.send text

  robot.respond /docker rmi (.*)/i, (msg) ->
    msg.send "Removing image " + msg.match[1].replace(/[\W]+/g, "") + "..."
    run_cmd 'docker rmi ' + msg.match[1].replace(/[\W]+/g, ""), (text) -> msg.send text

  robot.respond /docker rm (.*)/i, (msg) ->
    msg.send "Removing container " + msg.match[1].replace(/[\W]+/g, "") + "..."
    run_cmd 'docker rmi ' + msg.match[1].replace(/[\W]+/g, ""), (text) -> msg.send text

  robot.respond /docker bash (.*)/i, (msg) ->
    msg.send "Bash on " + msg.match[1].replace(/[\W]+/g, "") + "..."
    run_cmd 'docker exec -ti ' + msg.match[1].replace(/[\W]+/g, "") + ' /bin/bash', (text) -> msg.send text
  
  robot.respond /docker inspect (.*)/i, (msg) ->
    msg.send "Container inspect on " + msg.match[1].replace(/[\W]+/g, "") + "..."
    run_cmd 'docker inspect ' + msg.match[1].replace(/[\W]+/g, ""), (text) -> msg.send text

  robot.respond /docker network inspect (.*)/i, (msg) ->
    msg.send "Network inspect on " + msg.match[1].replace(/[\W]+/g, "") + "..."
    run_cmd 'docker network inspect ' + msg.match[1].replace(/[\W]+/g, ""), (text) -> msg.send text

  robot.respond /docker network ls$/i, (msg) ->
    run_cmd 'docker network ls', (text) -> msg.send text

  robot.respond /docker prune$/i, (msg) ->
    msg.send "Prune all Docker system " + msg.match[1].replace(/[\W]+/g, "") + "..."
    run_cmd 'yes | docker system prune -a', (text) -> msg.send text