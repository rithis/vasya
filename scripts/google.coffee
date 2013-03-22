# Commands:
#   вась погугли <запрос>

module.exports = (robot) ->
  robot.respond /погугли (.*)/i, (msg) ->
    googleMe msg, msg.match[1], (url) ->
      msg.send url

googleMe = (msg, query, callback) ->
  req = msg.http "http://www.google.com/search"
  req.query q: query
  req.get() (err, res, body) ->
    matches = body.match /class="r"><a href="\/url\?q=([^"]*)(&amp;sa.*)">/
    callback decodeURI matches?[1] if matches?[1]
