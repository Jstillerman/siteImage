fs = require 'fs'
casper = require("casper").create()
links = JSON.parse(fs.read('urls.json', 'utf8'))

phantom.addCookie {
	'name': "sessionid",
	'value': "se8xgtp94yi5yn3yjvfhblzloozjls8x",
	'domain': "www.admitster.com"
}


casper.start "http://www.google.com", ->
	console.log "STARTING..."

casper.then ->
	@eachThen links, (response) ->
		@thenOpen response.data, ->
			title = casper.evaluate(-> return document.URL.replace(/\//g, "-"), )
			console.log title
			@capture("img/" + title + ".png")
casper.run()
