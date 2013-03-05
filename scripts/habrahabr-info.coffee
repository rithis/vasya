# Commands:
#   <ссылка на статью на Хабрахабре>

module.exports = (robot) ->
    robot.hear /(http:\/\/habrahabr\.ru\/post\/\d+\/)/i, (msg) ->
        req = msg.http msg.match[1]
        req.get() (err, res, body) ->
            mathes = body.match /<title>(.*)<\/title>/
            title = mathes?[1]

            if title
                title = title.split("/")[0].trim()
                msg.send "Хабрахабр: #{title}"
