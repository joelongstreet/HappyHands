console.log 'broadcast file loading'

socket = io.connect '/'

$ ->
  
  interval = null
  
  $('#start').click ->

    socket.emit 'start_recording'

    record = [0,0,0,0,0,0,0,0,0]

    window.ondeviceorientation = (e) ->
      record[0] = e.alpha
      record[1] = e.beta
      record[2] = e.gamma

    window.ondevicemotion = (e) ->
      record[3] = e.acceleration.x
      record[4] = e.acceleration.y
      record[5] = e.acceleration.z
      record[6] = e.accelerationIncludingGravity.x
      record[7] = e.accelerationIncludingGravity.y
      record[8] = e.accelerationIncludingGravity.z

    interval = setInterval (->
      socket.emit 'record_update', record
    ), 10


  $('#stop').click ->
    clearInterval interval
    socket.emit 'record_stop'