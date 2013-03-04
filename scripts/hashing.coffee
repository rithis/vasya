# Commands:
#   вась <строка> в md5|sha|sha1|sha256|sha512

crypto = require "crypto"

module.exports = (robot) ->
    for algo in ["md5", "sha", "sha1", "sha256", "sha512"]
        do (algo) ->
            regexp = new RegExp "(.*) в #{algo}", "i"
            robot.respond regexp, (msg) ->
                hash = crypto.createHash algo
                hash.update msg.match[1], "utf8"
                msg.send hash.digest "hex"
