express         = require 'express'
path            = require 'path'
stylus          = require 'stylus'
bootstrap       = require 'bootstrap-stylus'
nib             = require 'nib'
app             = express.createServer()
port            = process.env.PORT || 3000
env             = process.env.environment || 'development'
io              = require('socket.io').listen app


app.use require('connect-assets')()

if env == 'development'
    io.configure ->
        io.set('log level', 2)
    app.use express.logger 'dev'
else
    io.configure ->
        io.set('log level', 1)

app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'jade'

app.use express.static path.join __dirname, 'public'

app.get '/', (req, res, next) ->
    user_agent = req.headers['user-agent']
    if /mobile/i.test user_agent
        res.render 'mobile'
    else
        res.render 'index'


###
app.get '/', (req, res) ->
    user_agent = req.headers['user-agent']
    if /mobile/i.test user_agent then res.sendfile __dirname + '/public/broadcast.html'
    else res.sendfile __dirname + '/public/listen.html'

app.get '/broadcast', (req, res) ->
    res.sendfile __dirname + '/public/broadcast.html'

app.get '/listen', (req, res) ->
    res.sendfile __dirname + '/public/listen.html'


io.sockets.on 'connection', (socket) ->

    socket.on 'alpha_update', (data) ->
        socket.broadcast.emit 'update_a', data

    socket.on 'beta_update', (data) ->
        socket.broadcast.emit 'update_b', data

    socket.on 'gamma_update', (data) ->
        socket.broadcast.emit 'update_g', data

    socket.on 'x_update', (data) ->
        socket.broadcast.emit 'update_x', data

    socket.on 'y_update', (data) ->
        socket.broadcast.emit 'update_y', data

    socket.on 'z_update', (data) ->
        socket.broadcast.emit 'update_z', data

###

console.log "listening on #{port} in #{env} environment"
app.listen port