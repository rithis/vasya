# Commands:
#   фейспалм

{isRobotMessage} = require "../lib/utils"

module.exports = (robot) ->
    robot.hear /(facepalm|фейспалм)/i, (msg) ->
        unless isRobotMessage msg, robot
            facepalmMe msg, (url) ->
                msg.send url

module.exports.facepalmMe = facepalmMe = (msg, callback) ->
    req = msg.http "http://facepalm.org/img.php"
    req.get() (err, res, body) ->
        callback "http://facepalm.org/#{res.headers["location"]}"
