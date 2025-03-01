
// Platforms always move first - this way we know that the character's state is valid going into character movement.

if !place_meeting(x + sign(xaccel), y + sign(yaccel), obj_block_place) {
    xspd = clamp(xspd + xaccel*global.s, -term, term)
    yspd = clamp(yspd + yaccel*global.s, -term, term)
}



moving_block_update()

