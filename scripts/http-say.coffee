# URLs:
#   GET /hubot/say?message=<message>&room=<room>

{parseQuery} = require "../lib/utils"

module.exports = (robot) ->
  robot.router.get "/hubot/say", (req, res) ->
    res.end()
    query = parseQuery req.url
    robot.send {room: query.room}, query.message
