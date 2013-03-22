# Commands:
#   вась покажи свежие посты на Хабре

utils = require "../lib/utils"


module.exports = utils.rssFetcher
    url: "http://habrahabr.ru/rss/hubs/"
    room: process.env.HUBOT_HABRAHABR_ROOM or "Shell"
    period: process.env.HUBOT_HABRAHABR_PERIOD or 60000
    respond: /вась покажи свежие посты на Хабре/i
    template: (article) ->
        "#{article.title} от #{article.author}: #{article.link}"
