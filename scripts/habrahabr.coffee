# Commands:
#   вась покажи свежие посты на Хабре

feedparser = require "feedparser"
events = require "events"
_ = require "lodash"


period = process.env.HUBOT_HABRAHABR_PERIOD or 60000
room = process.env.HUBOT_HABRAHABR_ROOM


module.exports = (robot) ->
    listener = new FeedListener "http://habrahabr.ru/rss/hubs/"

    listener.sync()

    listener.on "synced", ->
        listener.on "new", (article) ->
            robot.send {room: room}, "Новый пост на Хабре: #{template article}"

        listener.run period

        robot.respond /покажи свежие посты на Хабре/i, (msg) ->
            message = []

            for article in listener.cache
                message.push template article

            msg.send message.join "\n"


template = (article) ->
    "#{article.title} от #{article.author}: #{article.link}"


class FeedListener extends events.EventEmitter
    constructor: (@url) ->
        @cache = []

    sync: ->
        cache = []
        parser = feedparser.parseUrl @url

        parser.on "article", (article) =>
            cache.push article
            exists = _.filter @cache, (cachedArticle) ->
                article.guid is cachedArticle.guid

            if exists.length is 0
                @emit "new", article

        parser.on "end", =>
            @cache = cache
            @emit "synced"

    run: (period = 10000) ->
        setInterval @sync.bind(@), period
