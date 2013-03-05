# URLS:
#   POST /hubot/gh-commits?room=<room>

{parseQuery} = require "../lib/utils"

module.exports = (robot) ->
    robot.router.post "/hubot/gh-commits", (req, res) ->
        res.end()

        payload = JSON.parse req.body.payload

        message = []
        message.push "пришли новые коммиты от #{payload.commits[0].author.name} в #{payload.repository.name}"

        for commit in payload.commits
            message.push "    * #{commit.message} (#{commit.url})"

        query = parseQuery req.url
        robot.send {room: query.room}, message.join "\n"
