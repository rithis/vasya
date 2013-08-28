# Commands:
#   вась выбери между <а>, <б>, <в>

definitely = [
  "однозначно"
  "конечно"
  "абсолютно точно"
  "сто пудов"
]

module.exports = (robot) ->
  robot.respond /выбери(:| между) (.*)/i, (msg) ->
    options = msg.match[2].split ","
    options = options.map (option) ->
      option.trim()

    msg.reply "#{msg.random definitely} #{msg.random options}"
