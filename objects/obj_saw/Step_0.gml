if lateral_update() {

    x += dx;
    y += dy;
    
    if place_meeting(x + dx, y + dy, obj_block) || collision_point(x + sign(dx)*xfloor, y + sign(dy)*yfloor, obj_floor, false, true) == noone {
        xspd = -xspd;
        yspd = -yspd;
        image_xscale = -image_xscale;
    }
}