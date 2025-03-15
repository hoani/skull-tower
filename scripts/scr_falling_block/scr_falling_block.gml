function falling_block_collision(dx, dy){
    return check_collision_rectangle(x0 + dx, y0 + dy, x2 + dx, y2 + dy, collision_obj, excludes) != noone
}

function moving_block_falling() {
    if falling_block_collision(dx, dy) {
        while(!place_meeting(x + sign(dx), y+sign(dy), collision_obj)) {
            x += sign(dx);
            y += sign(dy);
        }
        xspd = 0;
        yspd = 0;
        create_sfx(snd_crash, x, y)
        return
    }
    x += dx;
    y += dy;
}
