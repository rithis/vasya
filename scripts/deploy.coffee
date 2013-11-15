# Commands:
#   вась деплой
#   вась деплой тихо


deploy = require "../lib/deploy"


module.exports = (robot) ->
  robot.respond /деплой( тихо)?/i, (msg) ->
    silent = msg.match[1] and msg.match[1].length > 0

    deploy (text) ->
      msg.reply text
    , silent
