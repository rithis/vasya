# Commands:
#   <ссылка на статью на Хабрахабре>

{isRobotMessage} = require "../lib/utils"

module.exports = (robot) ->
  robot.hear /(http:\/\/habrahabr\.ru\/post\/\d+\/)/i, (msg) ->
    unless isRobotMessage msg, robot
      req = msg.http msg.match[1]
      req.get() (err, res, body) ->
        mathes = body.match /<title>(.*)<\/title>/

        if mathes
          title = mathes?[1].split("/")[0].trim()
          msg.send "Хабрахабр: #{title}"
