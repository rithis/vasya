# Dependencies:
#   feedparser

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
            message = "Новый пост на Хабре: #{article.title} от #{article.author}: #{article.link}"
            robot.send {room: room}, message

        listener.run period


class FeedListener extends events.EventEmitter
    constructor: (@url) ->
        @guids = []

    sync: ->
        guids = []
        parser = feedparser.parseUrl @url

        parser.on "article", (article) =>
            guids.push article.guid
            exists = _.filter @guids, (guid) ->
                article.guid is guid

            if exists.length is 0
                @emit "new", article

        parser.on "end", =>
            @guids = guids
            @emit "synced"

    run: (period = 10000) ->
        setInterval @sync.bind(@), period
