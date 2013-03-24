feedparser = require "feedparser"
events = require "events"


class FeedListener extends events.EventEmitter
  constructor: (@url) ->
  sync: ->
    if /^http/.test @url
      parser = feedparser.parseUrl @url
    else
      parser = feedparser.parseFile @url

    parser.on "article", (article) =>
      @emit "article", article

    parser.on "end", =>
      @emit "end"

  run: (period = 10000) ->
    @sync()
    setInterval @sync.bind(@), period


module.exports = FeedListener
