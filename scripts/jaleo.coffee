# Description:
#   Get Party Hard Gifs from giphy.com
#
# Configuration:
#   HUBOT_GIPHY_API_KEY
#
# Commands:
#   co jaleo
#   co jaleo bueno
#   co party hard
#
# Author:
#  David Antón <davidantonlou@gmail.com>

giphy =
  api_key: process.env.HUBOT_GIPHY_API_KEY
  base_url: 'http://api.giphy.com/v1'

module.exports = (robot) ->
  robot.respond /(jaleo bueno|jaleo|party hard) (.*)/i, (msg) ->
    getGif msg, 'party hard', (url) ->
      msg.send url

getGif = (msg, query, cb) ->
  endpoint = '/gifs/search'
  url = "#{giphy.base_url}#{endpoint}"

  msg.http(url)
    .query
      q: query
      api_key: giphy.api_key
    .get() (err, res, body) ->
      response = undefined
      try
        response = JSON.parse(body)
        images = response.data
        if images.length > 0
          image = msg.random images
          cb image.images.original.url

      catch e
        response = undefined
        cb 'Error'

      return if response is undefined