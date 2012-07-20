express     = require 'express'
path        = require 'path'
stylus      = require 'stylus'
app         = express.createServer()
port        = process.env.PORT || 3000
env         = process.env.environment || 'development'
io          = require('socket.io').listen app

io.settings.logger.level = 0

app.configure ->
    app.use express.static path.join __dirname, 'public'
    app.use stylus.middleware
        debug: true 
        force: true
        src: "#{__dirname}/public"
        dest: "#{__dirname}/public"
    app.set 'views', path.join __dirname, 'public/views'
    app.set 'view engine', 'jade'


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


app.listen port