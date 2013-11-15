# Commands:
#   вась деплой
#   вась деплой тихо

childProcess = require "child_process"


deployProcess = null
interval = null
timeout = null


module.exports = (message, silent = false) ->
  if deployProcess isnt null
    message "деплой уже идет"
    return

  if silent
    message "начинаю тихий деплой"
  else
    message "начинаю деплой"

  deployProcess = childProcess.exec "./deploy.sh", (err, stdout, stderr) ->
    if err
      message "ошибка деплоя"
    else
      message "задеплоил ок"

    deployProcess = null

    if err and silent
      message "STDOUT:\n" + stdout.slice(-1000)
      message "STDERR:\n" + stderr.slice(-1000)

    unless silent
      clearInterval interval
      interval = null

    clearTimeout timeout
    timeout = null

  timeout = setTimeout ->
    message "деплой отвалился по таймауту"

    deployProcess.kill "SIGKILL"
    deployProcess = null

    unless silent
      clearInterval interval
      interval = null

    timeout = null
  , 1000 * 60 * 10

  unless silent
    output = ""

    replyOutput = ->
      if output.length > 0
        message output
        output = ""

    interval = setInterval replyOutput, 2000

    deployProcess.stdout.on "data", (data) ->
      output += data.toString()

    deployProcess.stderr.on "data", (data) ->
      output += data.toString()
