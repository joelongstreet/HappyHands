chai    = require 'chai'
assert  = require 'assert'
Zombie  = require 'zombie'

browser = new Zombie()
window = browser.window

chai.should()

{HappyHands} = require '../library' 

hands = null

describe 'Listeners', ->

    hands = new HappyHands window
    hands.accuracy.should.equal 5
    hands.poll_speed.should.equal 50
    
    punch       = [[20, 50, 15, 9, 3, 6, 80, 5 ,1], [29, 53, 12, 7, 5, 1, 88, 1 ,3]]
    some_var    = false

    punch_listener = hands.on punch, ->
        some_var = true

    it 'should initially be incomplete', ->
        punch_listener.complete.should.equal false
        some_var.should.equal false

    it 'should check itself when the window\'s orientation events change', ->
        hands.position = [23, 18, 12, 1, 5, 1, 60, 4, 2]
        hands.check_listeners()
        punch_listener.passes.should.equal 5

    it 'should execute a callback when completed', ->
        hands.position = [20, 50, 15, 9, 3, 6, 80, 5 ,1]
        hands.check_listeners()
        hands.position = [29, 53, 12, 7, 5, 1, 88, 1 ,3]
        hands.check_listeners()
        some_var.should.equal true
        punch_listener.remove_from_parent()

    it 'should delete itself when completed if kill on complete is passed in', ->
        punch           = [[20, 50, 15, 9, 3, 6, 80, 5 ,1]]

        hands.on punch, (->
            a = 1
        ),
        kill_on_complete : true

        hands.position  = [20, 50, 15, 9, 3, 6, 80, 5 ,1]
        hands.check_listeners()

        hands.listeners.length.should.equal 0