feedparser = require "feedparser"
events = require "events"
_ = require "lodash"


class FeedListener extends events.EventEmitter
    constructor: (@url) ->
        @cache = []

    sync: ->
        cache = []

        if /^http/.test @url
            parser = feedparser.parseUrl @url
        else
            parser = feedparser.parseFile @url

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


module.exports = FeedListener
