# Commands:
#   <ссылка на видео на YouTube>

querystring = require "querystring"
url = require "url"

module.exports = (robot) ->
    robot.hear /(https?:\/\/www\.youtube\.com\/watch\?.+?)(?:\s|$)/i, (msg) ->
        parsedUrl = url.parse msg.match[1]
        query = querystring.parse parsedUrl.query
        return unless query.v
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
