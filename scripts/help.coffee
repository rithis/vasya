# Commands:
#   вась что умеешь?

module.exports = (robot) ->
    robot.respond /(что|че) умеешь\??/i, (msg) ->
        msg.send robot.helpCommands().join "\n"
