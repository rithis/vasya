# Commands:
#   вась какие комнаты знаешь?

module.exports = (robot) ->
  robot.brain.data.rooms ||= []

  robot.hear /^/, (msg) ->
    room = msg.message.room
    robot.brain.data.rooms.push room unless room in robot.brain.data.rooms

  robot.respond /(какие )?комнаты( знаешь)?\??/i, (msg) ->
    msg.send robot.brain.data.rooms.join "\n"
