# Commands:
#   вась вручи ачивку <название>

module.exports = (robot) ->
    robot.respond /(вручи ачивку|ачивка) (.*)/i, (msg) ->
        caption = encodeURI msg.match[2]
        msg.send "http://achievement-unlocked.heroku.com/xbox/#{caption}.png"
