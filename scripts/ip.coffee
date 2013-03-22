# Commands:
#   вась какой твой ip?

module.exports = (robot) ->
  robot.respond /ip/i, (msg) ->
    req = msg.http "http://jsonip.com"
    req.get() (err, res, body) ->
      if res.statusCode is 200
        json = JSON.parse body
        msg.send "мой айпишник #{json.ip}"
      else
        msg.send "чейта не могу узнать свой IP, ошибка #{res.statusCode}"
