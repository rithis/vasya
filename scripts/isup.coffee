# Commands:
#   вась а <домен> упал?

module.exports = (robot) ->
    robot.respond /(а )?(.*) (упал|работает)\??/i, (msg) ->
        isUp msg, msg.match[2], (domain) ->
            msg.send domain

module.exports.isUp = isUp = (msg, domain, callback) ->
    req = msg.http "http://www.isup.me/#{domain}"
    req.get() (err, res, body) ->
        if body.match "It's just you."
            callback "#{domain} вроде работает"
        else if body.match "It's not just you!"
            callback "#{domain} походу упал"
        else
            callback "Фиг знает, что с #{domain}"
