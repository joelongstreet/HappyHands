HappyHands = ->


    initialize : (options) ->
        
        @sensitivity    = options.sensitivity || 5
        @position       = []

        window.ondevicemotion = (e) =>
            @position[3] = e.acceleration.x
            @position[4] = e.acceleration.y
            @position[5] = e.acceleration.z
            @position[6] = e.accelerationIncludingGravity.x
            @position[7] = e.accelerationIncludingGravity.y
            @position[8] = e.accelerationIncludingGravity.z

        window.ondeviceorientation = (e) =>
            @position[0] = e.alpha
            @position[1] = e.beta
            @position[2] = e.gamma


    create : (records, callback) ->

        start_time  = new Date().getTime()

        current     = 0
        passes      = 0

        for point in record[current]
            if Math.abs(point - @position[_i]) < @sensitivity
                passes++
        if passes == 9 then current++
            time = new Date().getTime() - start_time

            callback time