# Commands:
#   wat

module.exports = (robot) ->
    robot.hear /wat/i, (msg) ->
        if msg.message.user.name is not robot.name
            req = msg.http "http://watme.herokuapp.com/random"
            req.get() (err, res, body) ->
                msg.send JSON.parse(body).wat
