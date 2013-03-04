# URLs:
#   GET /hubot/say?message=<message>[&room=<room>][&type=<type>]

querystring = require "querystring"

module.exports = (robot) ->
    robot.router.get "/hubot/say", (req, res) ->
        res.end()

        query = querystring.parse req._parsedUrl.query

        user = {}
        user.room = query.room if query.room
        user.type = query.type if query.type

        robot.send user, query.message
