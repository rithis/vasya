cron = require "cron"

module.exports = (robot) ->
  if not process.env.HUBOT_PINGER_ROOM
    return

  interval = null

  doPing = ->
    if interval isnt null
      return

    robot.send {room: process.env.HUBOT_PINGER_ROOM}, process.env.HUBOT_PINGER_FIRST_MESSAGE

    interval = setInterval ->
      robot.send {room: process.env.HUBOT_PINGER_ROOM}, process.env.HUBOT_PINGER_NEXT_MESSAGE
    , process.env.HUBOT_PINGER_NEXT_MESSAGE_INTERVAL

  robot.hear /^/, (msg) ->
    if interval isnt null and msg.message.user.name is process.env.HUBOT_PINGER_USER
      robot.send {room: process.env.HUBOT_PINGER_ROOM}, process.env.HUBOT_PINGER_OK_MESSAGE
      clearInterval interval
      interval = null

  job = new cron.CronJob process.env.HUBOT_PINGER_CRON, doPing, null, false, "Europe/Moscow"
  job.start()
