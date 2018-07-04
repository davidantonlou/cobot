# Description:
#   Get Gifs from giphy.com. Returns an animated gif matching the requested search term.
#
# Configuration:
#   HUBOT_GIPHY_API_KEY
#
# Commands:
#   co gif me <query>
#   co giphy me <query>

giphy =
  api_key: process.env.HUBOT_GIPHY_API_KEY
  base_url: 'http://api.giphy.com/v1'

module.exports = (robot) ->
  robot.respond /(gif|giphy)( me)? (.*)/i, (msg) ->
    getGif msg, msg.match[3], (url) ->
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