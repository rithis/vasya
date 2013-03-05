# Commands:
#   wat

module.exports = (robot) ->
    robot.hear /wat/i, (msg) ->
        unless msg.message.user.name is robot.name
            req = msg.http "http://watme.herokuapp.com/random"
            req.get() (err, res, body) ->
                msg.send JSON.parse(body).wat
