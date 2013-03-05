# Commands:
#   вась <строка> в base64
#   вась <закодированная строка> из base64

module.exports = (robot) ->
    robot.respond /(.*) в base64/i, (msg) ->
        buffer = new Buffer msg.match[1]
        msg.send buffer.toString "base64"

    robot.respond /(.*) из base64/i, (msg) ->
        buffer = new Buffer msg.match[1], "base64"
        msg.send buffer.toString "utf8"
