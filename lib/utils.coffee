FeedListener = require "./feed_listener"
querystring = require "querystring"
url = require "url"

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
        listener = new FeedListener options.url

        listener.sync()

        listener.once "synced", ->
            listener.on "new", (article) ->
                robot.send {room: options.room}, options.template article

            listener.run options.period

            robot.respond options.respond, (msg) ->
                message = []

                for article in listener.cache
                    message.push template article

                msg.send message.join "\n"
