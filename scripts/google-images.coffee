# Commands:
#   вась скинь картинку о <запрос>
#   вась скинь гифку о <запрос>
#   вась добавь усов к <ссылка>
#   вась покажи усатого <запрос>

module.exports = (robot) ->
    robot.respond /с?кинь картинку об? (.*)/i, (msg) ->
        imageMe msg, msg.match[1], (url) ->
            msg.send url

    robot.respond /с?кинь гифку об? (.*)/i, (msg) ->
        imageMe msg, msg.match[1], true, (url) ->
            msg.send url

    robot.respond /покажи усат(ого|ую|ых|ое) (.*)/i, (msg) ->
        imageMe msg, msg.match[2], false, true, (url) ->
            msg.send mustachify url

    robot.respond /добавь усов (к|в|на) (.*)/i, (msg) ->
        msg.send mustachify msg.match[1]

mustachify = (url) ->
    type = Math.floor Math.random() * 3
    "http://mustachify.me/#{type}?src=#{url}"

imageMe = (msg, query, animated, faces, callback) ->
    callback = animated if typeof animated is "function"
    callback = faces if typeof faces is "function"

    query = v: "1.0", rsz: "8", q: query, safe: "off"
    query.as_filetype = "gif" if typeof animated is "boolean" and animated is true
    query.imgtype = "face" if typeof faces is "boolean" and faces is true

    req = msg.http "http://ajax.googleapis.com/ajax/services/search/images"
    req.query query
    req.get() (err, res, body) ->
        images = JSON.parse body
        images = images.responseData?.results

        if images?.length > 0
            image = msg.random images
            callback image.unescapedUrl
