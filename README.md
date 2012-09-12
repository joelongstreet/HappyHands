# HAPPY HANDS :raised_hands: :clap: :punch:

Happy Hands is a client side javascript library which helps you detect physical gestures coming from a mobile device.

## Planned Sample Usage:

    script(src = '/HappyHands.js')

    punch = [[20, 50, 15, 9, 3, 6, 80, 5 ,1], [20, 50, 15, 9, 3, 6, 80, 5 ,1]]
    kick  = [[20, 50, 15, 9, 3, 6, 80, 5 ,1], [20, 50, 15, 9, 3, 6, 80, 5 ,1]]
    slap  = [[20, 50, 15, 9, 3, 6, 80, 5 ,1], [20, 50, 15, 9, 3, 6, 80, 5 ,1]]

    hands = new HappyHands(
        accuracy    : 5
        poll_speed  : 3
    )

### Single Events

    hands.on punch, ->
        alert 'FACE PUNCH'

    hands.on slap, ->
        alert 'KICK'


### Sequential Events

    hands.on punch, ->
        hands.on slap, ->
            alert 'PUNCH SLAP'


## Generating "Records"
Records can be created from going to the happy hands web site and recording a gesture.

## Testing
`mocha --compilers coffee:coffee-script -R spec`