# Commands:
#   вась вручи ачивку <название>

module.exports = (robot) ->
  robot.respond /(вручи ачивку|ачивка) (.*)/i, (msg) ->
    caption = msg.match[2].replace " ", "%20"
    msg.send "http://achievement-unlocked.heroku.com/xbox/#{caption}.png"
