if lateral_update() {

    x += dx;
    y += dy;
    
    xfloor = ((w_2 + 1) * abs(fcos) * sign(xspd)) + fsin;
    yfloor = ((w_2 + 1) * abs(fsin) * sign(yspd)) + fcos;
    
    if place_meeting(x + dx, y + dy, obj_block_place) || collision_point(x + xfloor, y + yfloor, [obj_floor_place, obj_block_place], false, true) == noone {
        xspd = -xspd;
        yspd = -yspd;
        image_xscale = -image_xscale;
    }
}