
fs = require 'fs'
async = require 'async'
express = require 'express'
bodyParser = require 'body-parser'
exec = require('child_process').exec



app = express()
app.use bodyParser.json()



app.post '/', (req, res) ->

	hexCol = /[0-9A-Fa-f]+/.exec(req.body.hex)[0]

	red = parseInt(hexCol[0..1], 16) / 255
	green = parseInt(hexCol[2..3], 16) / 255
	blue = parseInt(hexCol[4..5], 16) / 255

	#console.log "rgb(#{red*255}, #{green*255}, #{blue*255})"

	async.series [
		(callback) -> exec "echo \"17=#{red}\" > /dev/pi-blaster", callback
		(callback) -> exec "echo \"22=#{green}\" > /dev/pi-blaster", callback
		(callback) -> exec "echo \"24=#{blue}\" > /dev/pi-blaster", callback
	], (err) ->
		if err then throw err
		else res.sendStatus 200



app.listen 8080



