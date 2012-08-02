# HAPPY HANDS :raised_hands: :clap: :punch:

Happy Hands is a client side javascript library which helps you detect physical gestures coming from a mobile device.

## Planned Sample Usage:

    script(src = '/HappyHands.js')

    hands   = new HappyHands
    records = [[20, 50, 15, 9, 3, 6, 80, 5 ,1], [20, 50, 15, 9, 3, 6, 80, 5 ,1]]

    hands.create records, ->
        alert 'gesture complete'


## Generating "Records"
Records can be created from going to the happy hands web site and recording a gesture.