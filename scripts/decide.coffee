# Commands:
#   вась выбери между <а>, <б> и <в>

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
    last = options.pop().split /\ (и|или) /i
    last = _.without last, "и", "или"
    options = _.union options, last
    options = _.map options, (option) ->
      option.trim()

    msg.reply "#{msg.random definitely} #{msg.random options}"
