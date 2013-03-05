querystring = require "querystring"
url = require "url"

robotNames = process.env.HUBOT_NAMES or ""
robotNames = robotNames.split ","

module.exports.isRobotMessage = (msg, robot) ->
    return true if msg.message.user.name is robot.name
    robotNames.indexOf(msg.message.user.name) >= 0

module.exports.parseQuery = (link) ->
    parsedUrl = url.parse link
    querystring.parse parsedUrl.query
