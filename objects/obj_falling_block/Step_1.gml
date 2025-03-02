
// Platforms always move first - this way we know that the character's state is valid going into character movement.

if !place_meeting(x + sign(xaccel), y + sign(yaccel), obj_block_place) {
    var xmin = sign(xaccel) == -1 ? -term : xspd;
    var xmax = sign(xaccel) == 1 ? term : xspd;
    
    var ymin = sign(yaccel) == -1 ? -term : yspd;
    var ymax = sign(yaccel) == 1 ?  term : yspd;
    
    xspd = clamp(xspd + xaccel*global.s, xmin, xmax)
    yspd = clamp(yspd + yaccel*global.s, ymin, ymax)
}



moving_block_update()

