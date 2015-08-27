fs = require 'fs'
casper = require("casper").create()
links = JSON.parse(fs.read('urls.json', 'utf8'))

DEVICE = "iPhone 4S"

phantom.addCookie {
	'name': "sessionid",
	'value': "se8xgtp94yi5yn3yjvfhblzloozjls8x",
	'domain': "www.admitster.com"
}

getViewPortWidth = (device) ->
	devices = JSON.parse fs.read('devices.json', 'utf8')
	for dev in devices when dev["Device Name"] is device
		console.log "Setting Vewport for " + DEVICE
		return  parseInt dev["Portrait Width"]
	console.log "DEVICE NOT FOUND"


casper.start "http://www.google.com", ->
	casper.viewport(getViewPortWidth(DEVICE), 768)
	console.log "STARTING..."

casper.then ->
	@eachThen links, (response) ->
		@thenOpen response.data, ->
			title = casper.evaluate(-> return document.URL.replace(/\//g, "-"), )
			console.log title
			@capture("img/" + title + ".png")
casper.run()
