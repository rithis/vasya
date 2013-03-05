# URLS:
#   POST /hubot/gh-commits?room=<room>[&type=<type>]

querystring = require "querystring"
url = require "url"

module.exports = (robot) ->
    robot.router.post "/hubot/gh-commits", (req, res) ->
        res.end()

        payload = JSON.parse req.body.payload
        message = []

        message.push "пришли новые коммиты от #{payload.commits[0].author.name} в #{payload.repository.name}"

        for commit in payload.commits
            message.push "    * #{commit.message} (#{commit.url})"

        parsedUrl = url.parse req.url
        query = querystring.parse parsedUrl.query

        user = {}
        user.room = query.room if query.room
        user.type = query.type if query.type

        robot.send user, message.join "\n"
