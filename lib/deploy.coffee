childProcess = require "child_process"


deployProcess = null
timeout = null


module.exports = (message) ->
  if deployProcess isnt null
    message "деплой уже идет"
    return

  message "начинаю деплой"

  deployProcess = childProcess.exec "./deploy.sh", (err, stdout, stderr) ->
    if err
      message "ошибка деплоя"
    else
      message "задеплоил ок"

    deployProcess = null

    if err
      message stderr.split('\n').slice(-25).join('\n')

    clearTimeout timeout
    timeout = null

  timeout = setTimeout ->
    message "деплой отвалился по таймауту"

    deployProcess.kill "SIGKILL"
    deployProcess = null

    timeout = null
  , 1000 * 60 * 10

  deployProcess.stdout.on "data", (data) ->
    message data.toString()
