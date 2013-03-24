# Commands:
#   вась покажи свежие посты на Хабре
#   вась включи Хабр
#   вась выключи Хабр
#   вась включен ли Хабр?

utils = require "../lib/utils"


module.exports = utils.rssFetcher
  url: "http://habrahabr.ru/rss/hubs/"
  name: "habrahabr"
  period: process.env.HUBOT_HABRAHABR_PERIOD or 60000
  listRegexp: /покажи свежие посты на Хабре/i
  onRegexp: /включи Хабр/i
  offRegexp: /выключи Хабр/i
  checkRegexp: /вы?ключен ли Хабр\??/i
  template: (article) ->
    "#{article.title} от #{article.author}: #{article.link}"
