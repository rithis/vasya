# Commands:
#   фейспалм

module.exports = (robot) ->
    robot.hear /(facepalm|фейспалм)/i, (msg) ->
        unless msg.message.user.name is robot.name
            facepalmMe msg, (url) ->
                msg.send url

module.exports.facepalmMe = facepalmMe = (msg, callback) ->
    req = msg.http "http://facepalm.org/img.php"
    req.get() (err, res, body) ->
        callback "http://facepalm.org/#{res.headers["location"]}"
