# Commands:
#   вась кинь монетку

module.exports = (robot) ->
  robot.respond /кинь монетку/i, (msg) ->
    msg.reply msg.random ["орел", "решка"]
