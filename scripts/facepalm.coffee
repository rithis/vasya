# Commands:
#   фейспалм

imageMe = require("./google-images").imageMe

module.exports = (robot) ->
    robot.hear /(facepalm|фейспалм)/i, (msg) ->
        if msg.random [true, false]
            facepalmMe msg, (url) ->
                msg.send url
        else
            imageMe msg, "facepalm", (url) ->
                msg.send url

module.exports.facepalmMe = facepalmMe = (msg, callback) ->
    req = msg.http "http://facepalm.org/img.php"
    req.get() (err, res, body) ->
        callback "http://facepalm.org/#{res.headers["location"]}"
