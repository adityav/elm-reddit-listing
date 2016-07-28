var http = require('http'),
    httpProxy = require('http-proxy');

var proxy = httpProxy.createProxyServer({target:'http://api.reddit.com'})

proxy.on('error', function(e) {
	console.log("Got error:", e);
});

proxy.listen(8000);
console.log("Proxy started!");
