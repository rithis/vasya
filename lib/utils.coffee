FeedListener = require "./feed_listener"
querystring = require "querystring"
url = require "url"
_ = require "lodash"

robotNames = process.env.HUBOT_NAMES or ""
robotNames = robotNames.split ","

module.exports.isRobotMessage = (msg, robot) ->
  return true if msg.message.user.name is robot.name
  robotNames.indexOf(msg.message.user.name) >= 0

module.exports.parseQuery = (link) ->
  parsedUrl = url.parse link
  querystring.parse parsedUrl.query

module.exports.rssFetcher = (options) ->
  (robot) ->
    robot.brain.data.feeds ||= {}
    robot.brain.data.feeds[options.name] ||= articles: [], rooms: []
    feed = robot.brain.data.feeds[options.name]

    listener = new FeedListener options.url
    firstRun = true

    listener.on "article", (article) ->
      exists = _.filter feed.articles, (archivedArticle) ->
        article.guid == archivedArticle.guid

      if exists.length == 0
        if firstRun
          feed.articles.push article
        else
          feed.articles.unshift article

        unless firstRun
          for room in feed.rooms
            robot.send {room: room}, options.template article

        if feed.articles.length > 100
          feed.articles = feed.articles.slice(0, 100)

    listener.once "end", ->
      firstRun = false

    robot.brain.once "loaded", ->
      listener.run options.period

    robot.brain.on "loaded", ->
      feed = robot.brain.data.feeds[options.name]

    robot.respond options.listRegexp, (msg) ->
      message = []

      for article in feed.articles.slice(0, 10)
        message.push options.template article

      msg.send message.join "\n"

    robot.respond options.onRegexp, (msg) ->
      feed.rooms.push msg.message.room unless msg.message.room in feed.rooms

    robot.respond options.offRegexp, (msg) ->
      feed.rooms = _.filter feed.rooms, (room) ->
        msg.message.room isnt room

    robot.respond options.checkRegexp, (msg) ->
      msg.send if msg.message.room in feed.rooms then "тру" else "фалс"
