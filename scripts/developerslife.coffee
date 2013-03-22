# Commands:
#   вась покажи свежие гифки с developerslife

utils = require "../lib/utils"


module.exports = utils.rssFetcher
  url: "http://developerslife.ru/rss.xml"
  room: process.env.HUBOT_DEVELOPERSLIFE_ROOM or "Shell"
  period: process.env.HUBOT_DEVELOPERSLIFE_PERIOD or 60000
  respond: /покажи свежие гифки с developerslife/i
  template: (article) ->
    "#{article.title}: #{article.link}"
