querystring = require "querystring"
url = require "url"

module.exports.parseQuery = (link) ->
    parsedUrl = url.parse link
    querystring.parse parsedUrl.query
