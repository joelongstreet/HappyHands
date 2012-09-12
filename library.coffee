class exports.HappyHands

    constructor : (window, options) ->
        
        if options
            @accuracy   = options.accuracy || 5
            @poll_speed = options.poll_speed || 50
        else
            @accuracy   = 5
            @poll_speed = 50

        @listeners  = []
        @position   = [0,0,0,0,0,0,0,0,0]

        window.ondeviceorientation = (e) =>
            @position[0] = e.alpha
            @position[1] = e.beta
            @position[2] = e.gamma

        window.ondevicemotion = (e) =>
            @position[3] = e.acceleration.x
            @position[4] = e.acceleration.y
            @position[5] = e.acceleration.z
            @position[6] = e.accelerationIncludingGravity.x
            @position[7] = e.accelerationIncludingGravity.y
            @position[8] = e.accelerationIncludingGravity.z

        #setInterval (=> @check_listeners()), @poll_speed

    on : (records, callback) ->
        listener = new Listener records, @, callback
        @listeners.push listener
        return listener

    check_listeners : ->
        for listener in @listeners
            listener.check_status()


class Listener
    
    constructor : (@records, @parent, @callback) ->

        @complete       = false
        @current_pos    = 0
        @time           = 0
        @passes         = 0


    check_status : ->

        @passes = 0

        start_time = new Date().getTime()
        
        for point in @records[@current_pos]
            if Math.abs(point - @parent.position[_i]) < @parent.accuracy
                @passes++
                if @passes == 9 then @current_pos++

        if @passes == 9 && (@current_pos == @records.length)
            @time = new Date().getTime() - start_time
            @callback()


    you_complete_me : ->
        @complete = true
        @callback()