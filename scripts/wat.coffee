# Commands:
#   wat

{isRobotMessage} = require "../lib/utils"

module.exports = (robot) ->
    robot.hear /wat/i, (msg) ->
        unless isRobotMessage msg, robot
            req = msg.http "http://watme.herokuapp.com/random"
            req.get() (err, res, body) ->
                msg.send JSON.parse(body).wat
