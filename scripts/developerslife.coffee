# Commands:
#   вась покажи свежие гифки с developerslife
#   вась включи developerslife
#   вась выключи developerslife
#   вась включен ли developerslife?

utils = require "../lib/utils"


module.exports = utils.rssFetcher
  url: "http://developerslife.ru/rss.xml"
  name: "developerslife"
  period: process.env.HUBOT_DEVELOPERSLIFE_PERIOD or 60000
  listRegexp: /покажи свежие гифки с developerslife/i
  onRegexp: /включи developerslife/i
  offRegexp: /выключи developerslife/i
  checkRegexp: /вы?ключен ли developerslife\??/i
  template: (article) ->
    "#{article.title}: #{article.link}"
