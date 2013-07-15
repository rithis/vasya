FeedParser = require "feedparser"
request = require "request"
events = require "events"
fs = require "fs"


class FeedListener extends events.EventEmitter
  constructor: (@url) ->
  sync: ->
    if /^http/.test @url
      stream = request @url
    else
      stream = fs.createReadStream @url

    parser = stream.pipe(new FeedParser)

    parser.on "meta", (article) =>
      @emit "article", article

    parser.on "end", =>
      @emit "end"

  run: (period = 10000) ->
    @sync()
    setInterval @sync.bind(@), period


module.exports = FeedListener
