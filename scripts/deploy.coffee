# Commands:
#   вась деплой
#   вась деплой тихо

childProcess = require "child_process"


module.exports = (robot) ->
  process = null
  interval = null

  robot.respond /деплой( тихо)?/i, (msg) ->
    silent = msg.match[1] and msg.match[1].length > 0

    if process isnt null
      msg.reply "деплой уже идет"
      return

    if silent
      msg.reply "начинаю тихий деплой"
    else
      msg.reply "начинаю деплой"

    process = childProcess.exec "./deploy.sh", (err, stdout, stderr) ->
      if err
        msg.reply "ошибка деплоя"
      else
        msg.reply "задеплоил ок"

      process = null

      if err and silent
        msg.reply "STDOUT:\n" + stdout.slice(-1000)
        msg.reply "STDERR:\n" + stderr.slice(-1000)

      unless silent
        clearInterval interval
        interval = null

    unless silent
      output = ""

      replyOutput = ->
        if output.length > 0
          msg.reply output
          output = ""

      interval = setInterval replyOutput, 2000

      process.stdout.on "data", (data) ->
        output += data.toString()

      process.stderr.on "data", (data) ->
        output += data.toString()
