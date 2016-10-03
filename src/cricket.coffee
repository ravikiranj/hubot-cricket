# Description:
#   Display cricket scores for current live games
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cricket - Returns the current score of all live games
#
# Author:
#   adtaylor,ravikiranj (port to hubot package)

module.exports = (robot) ->
  feed_url = "http://query.yahooapis.com/v1/public/yql?q=select%20title%20from%20rss%20where%20url%3D%22http%3A%2F%2Fstatic.cricinfo.com%2Frss%2Flivescores.xml%22&format=json&diagnostics=true&callback="
  robot.respond /cricket/i, (msg) ->
    query = msg.match[1]?.toUpperCase()
    msg.http(feed_url)
      .get() (err, res, body) ->
        results = JSON.parse body
        scores = results.query.results?.item
        if not scores
          return msg.send prefix + "No games currently in progress."
        else
          scores.forEach (score)->
            msg.send score.title
