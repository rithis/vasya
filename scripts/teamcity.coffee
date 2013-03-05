# Commands:
#   вась какие проекты есть в TeamCity?
#   вась какие конфигурации есть в TeamCity?
#   вась перечисли последние билды <конфигурация>
#   вась запусти билд <конфигурация>

util = require "util"
_ = require "lodash"

module.exports = (robot) ->
    robot.respond /(какие )?проекты (есть )?(в )?TeamCity\??/i, (msg) ->
        getProjects msg, (err, projects) ->
            return msg.send "нет проектов" unless projects

            projects = _.map projects, (project) ->
                project.name

            msg.send projects.join ", "

    robot.respond /(какие )?конфигурации (есть )?(в )?TeamCity\??/i, (msg) ->
        getBuildTypes msg, (err, buildTypes) ->
            return msg.send "нет конфигураций" unless buildTypes

            buildTypes = _.map buildTypes, (project) ->
                project.name

            msg.send buildTypes.join ", "

    robot.respond /(перечисли )?(последние )?билды (.*)/i, (msg) ->
        name = msg.match[3]
        getBuilds msg, name, (err, builds) ->
            return msg.send "нет билдов для #{name}" unless builds

            message = []

            for build in builds
                line = []
                if build.running
                    line.push "в процессе билд ##{build.number} от бранча #{build.branchName},"
                    line.push "готов на #{build.percentageComplete}%:"
                else
                    line.push if build.status is "SUCCESS" then "рабочий" else "сломанный"
                    line.push "билд ##{build.number} от бранча #{build.branchName}:"

                line.push "#{build.webUrl}"
                message.push line.join " "

            msg.send message.join "\n"

    robot.respond /запусти билд (.*)/i, (msg) ->
        getBuildTypeId msg, msg.match[1], (err, buildTypeId) ->
            return msg.send "нет такой конфигурации" unless buildTypeId

            postBuild msg, buildTypeId, (err) ->
                if err
                    msg.send "йо, билд стартовал"
                else
                    msg.send "не смог запустить :("

getHeaders = ->
    username = process.env.HUBOT_TEAMCITY_USERNAME
    password = process.env.HUBOT_TEAMCITY_PASSWORD

    buffer = new Buffer "#{username}:#{password}"

    Authorization: "Basic #{buffer.toString "base64"}"
    Accept: "application/json"

hostname = process.env.HUBOT_TEAMCITY_HOSTNAME
headers = getHeaders()

fetch = (msg, url, callback) ->
    req = msg.http url
    req.headers headers
    req.get() (err, res, body) ->
        return callback err if err
        body = JSON.parse body
        return callback body unless res.statusCode == 200
        callback null, body

getProjects = (msg, callback) ->
    url = "http://#{hostname}/httpAuth/app/rest/projects"
    fetch msg, url, (err, body) ->
        callback err, body?.project or null

getBuildTypes = (msg, callback) ->
    url = "http://#{hostname}/httpAuth/app/rest/buildTypes"
    fetch msg, url, (err, body) ->
        callback err, body?.buildType or null

getBuilds = (msg, id, callback) ->
    url = "http://#{hostname}/httpAuth/app/rest/buildTypes/name:#{encodeURI id}/builds?locator=lookupLimit:5,running:any"
    fetch msg, url, (err, body) ->
        callback err, body?.build or null

getBuildTypeId = (msg, name, callback) ->
    getBuildTypes msg, (err, buildTypes) ->
        return callback err if err

        buildType = _.find buildTypes, (buildType) ->
            buildType.name is name

        callback null, buildType?.id or null

postBuild = (msg, buildTypeId, callback) ->
    url = "http://#{hostname}/httpAuth/action.html?add2Queue=#{buildTypeId}"
    req = msg.http url
    req.headers headers
    req.get() (err, res, body) ->
        callback res.statusCode is 200
