# URLS:
#   POST /hubot/gh-commits?room=<room>
#   POST /hubot/gh-commits?room=<room>&deploy=true

{parseQuery} = require "../lib/utils"
deploy = require "../lib/deploy"

module.exports = (robot) ->
  robot.router.post "/hubot/gh-commits", (req, res) ->
    res.end()

    payload = JSON.parse req.body.payload

    payload.commits.reverse()

    message = []
    message.push "пришли новые коммиты от #{payload.commits[0].author.name} в #{payload.repository.name}"

    for commit in payload.commits
      message.push "    * #{commit.message.split("\n")[0]} (#{commit.url})"

    query = parseQuery req.url
    robot.send {room: query.room}, message.join "\n"

    if query.deploy
      deploy (text) ->
        robot.send {room: query.room}, text
      , true
