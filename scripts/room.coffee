# Commands:
#   вась что это за комната?

module.exports = (robot) ->
    robot.respond /(что (это )?за )?комната\??/i, (msg) ->
        msg.send msg.message.room
