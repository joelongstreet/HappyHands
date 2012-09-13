chai    = require 'chai'
assert  = require 'assert'
Zombie  = require 'zombie'

browser = new Zombie()
window = browser.window

chai.should()

{HappyHands} = require '../lib/library' 

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

    it 'should allow listeners to be deleted', ->
        for listener in hands.listeners
            listener.remove_from_parent()

        hands.listeners.length.should.equal 0