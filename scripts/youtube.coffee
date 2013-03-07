# Commands:
#   вась скинь видео о <запрос>

module.exports = (robot) ->
    robot.respond /с?кинь видео об? (.*)/i, (msg) ->
        videoMe msg, msg.match[1], (url) ->
            msg.send url

videoMe = (msg, query, callback) ->
    query = q: query, alt: "json"

    req = msg.http "http://gdata.youtube.com/feeds/api/videos"
    req.query query
    req.get() (err, res, body) ->
        videos = JSON.parse body
        videos = videos?.feed?.entry

        if videos?.length > 0
            callback videos[0].link[0].href
