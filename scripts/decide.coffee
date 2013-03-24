# Commands:
#   вась выбери между <а>, <б>, <в>

_ = require "lodash"

definitely = [
  "однозначно"
  "конечно"
  "абсолютно точно"
  "сто пудов"
]

module.exports = (robot) ->
  robot.respond /выбери(:| между) (.*)/i, (msg) ->
    options = msg.match[2].split ","
    options = _.map options, (option) ->
      option.trim()

    msg.reply "#{msg.random definitely} #{msg.random options}"
