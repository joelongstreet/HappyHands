chai    = require 'chai'
assert  = require 'assert'
Zombie  = require 'zombie'

browser = new Zombie()
window = browser.window

chai.should()

{HappyHands} = require '../library' 


hands = null


describe 'The Library', ->

    hands = new HappyHands window

    it 'should work if no options are passed', ->
        hands.accuracy.should.equal 5
        hands.poll_speed.should.equal 50

    it 'should accept new listeners', ->
        punch = [[20, 50, 15, 9, 3, 6, 80, 5 ,1], [20, 50, 15, 9, 3, 6, 80, 5 ,1]]
        action_complete = false

        punch_listener = hands.on punch, ->
            action_complete = true

        punch_listener.records.should.equal punch

    #it 'should allow listeners to be removed', ->
        #hands.listeners.splice(hands.listeners.length, 1)
        #hands.listeners.length.should.equal 0



describe 'Listeners', ->
    
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