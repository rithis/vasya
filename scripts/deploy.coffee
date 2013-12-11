# Commands:


deploy = require "../lib/deploy"


module.exports = (robot) ->
  robot.respond /деплой/i, (msg) ->
    deploy (text) ->
      msg.reply text
