# Commands:
#   вась деплой

childProcess = require "child_process"


module.exports = (robot) ->
  process = null
  interval = null

  robot.respond /деплой/i, (msg) ->
    if process isnt null
      msg.reply "деплой уже идет"
      return

    msg.reply "начинаю деплой"

    process = childProcess.exec "./deploy.sh", (err, stdout, stderr) ->
      if err
        msg.reply "ошибка деплоя"
      else
        msg.reply "задеплоил ок"

      process = null
      clearInterval interval
      interval = null

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
