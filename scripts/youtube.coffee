# Commands:
#   вась скинь случайное видео о <запрос>
#   вась скинь видео о <запрос>

module.exports = (robot) ->
  robot.respond /с?кинь (случайное|рандомное) видео об? (.*)/i, (msg) ->
    videoMe msg, msg.match[1], true, (url) ->
      msg.send url

  robot.respond /с?кинь видео об? (.*)/i, (msg) ->
    videoMe msg, msg.match[1], false, (url) ->
      msg.send url

videoMe = (msg, query, random, callback) ->
  query = q: query, alt: "json"

  req = msg.http "http://gdata.youtube.com/feeds/api/videos"
  req.query query
  req.get() (err, res, body) ->
    videos = JSON.parse body
    videos = videos?.feed?.entry

    if videos?.length > 0
      video = if random then msg.random videos else videos[0]
      callback video.link[0].href
