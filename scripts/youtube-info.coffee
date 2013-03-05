# Commands:
#   <ссылка на видео на YouTube>

{parseQuery} = require "../lib/utils"

module.exports = (robot) ->
    robot.hear /(https?:\/\/www\.youtube\.com\/watch\?.+?)(?:\s|$)/i, (msg) ->
        query = parseQuery msg.match[1]

        if query.v
            req = msg.http "http://gdata.youtube.com/feeds/api/videos/#{query.v}"
            req.query alt: "json"
            req.get() (err, res, body) ->
                entry = JSON.parse(body).entry
                msg.send "YouTube: #{entry.title.$t} (#{formatTime(entry.media$group.yt$duration.seconds)})"

formatTime = (seconds) ->
    min = Math.floor seconds / 60
    sec = seconds % 60

    result = ""
    result += "#{min}m" if min > 0
    result += "#{sec}s" if sec > 0
    result
