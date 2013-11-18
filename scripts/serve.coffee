# Commands:


express = require "express"
path = require "path"


module.exports = (robot) ->
  app = express()

  app.use express.static path.join __dirname, "..", "markup"

  app.listen 8998
