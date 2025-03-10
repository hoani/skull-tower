

// Note:
// Angled moving blocks are not supported, the challenges with angled moving blocks would require a different
// platforming engine since the pushing of bodies isn't really using any physics principles.

function moving_block_wraparound() {
    x += dx;
    if x0 > room_width && x1 > room_width && x2 > room_width && x3 > room_width {
        x -= (room_width + max(abs(x0 - x1), abs(x1 - x2)));
    }
    
    if x0 < 0 && x1 < 0 && x2 < 0 && x3 < 0 {
        x += (room_width + max(abs(x0 - x1), abs(x1 - x2)));
    }
    
    y += dy;
    if y0 > room_height && y1 > room_height && y2 > room_height && y3 > room_height {
        y -= (room_height + max(abs(y0 - y1), abs(y1 - y2)));
    }
    
    if y0 < 0 && y1 < 0 && y2 < 0 && y3 < 0 {
        y += (room_height + max(abs(y0 - y1), abs(y1 - y2)));
    }
}


function moving_block_falling() {
    if place_meeting(x + dx, y+dy, obj_block_place) {
        while(!place_meeting(x + sign(dx), y+sign(dy), obj_block_place)) {
            x += sign(dx);
            y += sign(dy);
        }
        xspd = 0;
        yspd = 0;
        create_sfx(x, y, snd_crash)
        return
    }
    x += dx;
    y += dy;
}

function moving_delta_update() {
    return lateral_update()
}

function moving_floor_update() {
    
    if !moving_delta_update() {
        return;
    }
    
    floor_bodies = [];
    push_bodies = [];
    // Collect all candidates.
    with (obj_body) {
        var _pspd = g.convert(other.dx, other.dy, global.g);
        if f.floor.inst == other.id {
            array_push(other.floor_bodies, id);
        } else if _pspd.y < 0 && place_meeting(x - other.dx, y - other.dy, other.id) && !place_meeting(x, y, other.id)  {
            array_push(other.push_bodies, id);
        }
        if place_meeting(x - other.dx, y - other.dy, other.id) {
            show_debug_message($"block colliding ${place_meeting(x, y, other.id)}")
        }
    }
    
    
    for (var i = 0; i<array_length(floor_bodies); i++) {
        var body = floor_bodies[i];
        with(body) {
            var _pspd = g.convert(other.dx, other.dy, global.g);
            if _pspd.y < 0 {
                var contact = move_contact_y(_pspd.y, obj_block);
                if contact != noone {
                    squash_floor(_pspd.x, _pspd.y);
                }
            }
        }
    }
    
    for (var i = 0; i<array_length(push_bodies); i++) {
        var body = push_bodies[i];
        with(body) {
            var _pspd = g.convert(other.dx, other.dy, global.g);
            var contact = move_contact_y(_pspd.y, obj_block);
            if contact != noone {
                squash_floor(_pspd.x, _pspd.y);
            }
        }
    }
    
    
    do_move()
    
    floor_update_coords()
    
    
    for (var i = 0; i<array_length(push_bodies); i++) {
        var body = push_bodies[i];
        with(body) {
            var _pspd = g.convert(other.dx, other.dy, global.g);
            move_contact_y(-_pspd.y, obj_floor);
        }
    }
    
    for (var i = 0; i<array_length(floor_bodies); i++) {
        var body = floor_bodies[i];
        with(body) {
            var _pspd = g.convert(other.dx, other.dy, global.g);
            move_contact_x(_pspd.x, obj_block);
            if _pspd.y > 0 {
                move_contact_y(_pspd.y, obj_floor);
            }
        }
    }
}

function moving_block_update() {
    
    if !moving_delta_update() {
        return;
    }
    
    floor_bodies = [];
    push_bodies = [];
    wall_bodies = [];
    // Collect all candidates.
    with (obj_body) {
        var _pspd = g.convert(other.dx, other.dy, global.g);
        if f.floor.inst == other.id || f.hang == other.id {
            array_push(other.floor_bodies, id);
        } else if (f.wall.left == other.id || f.wall.right == other.id) && sign(spd.x) == sign(_pspd.x) && abs(spd.x) > abs(_pspd.x) {
            array_push(other.wall_bodies, id);
        } else if place_meeting(x - other.dx, y - other.dy, other.id) && !array_contains(f.excludes, other.id)  {
            array_push(other.push_bodies, id);
        }
    }
    
    for (var i = 0; i<array_length(floor_bodies); i++) {
        var body = floor_bodies[i];
        with(body) {
            var _pspd = g.convert(other.dx, other.dy, global.g);
            if sign(face) != sign(_pspd.x) {
                var contact = move_contact_x(_pspd.x, obj_block); // Only move x if it is moving away from the block.
                if contact != noone && other.id == f.hang {
                    squash_block(_pspd.x, _pspd.y);
                }
            }
            if _pspd.y < 0 {
                var contact = move_contact_y(_pspd.y, obj_block, true, true);
                if contact != noone {
                    if other.id == f.hang {
                        f.hang = noone;
                    } else {
                        squash_block(_pspd.x, _pspd.y);
                    }
                }
            }
        }
    }
    
    for (var i = 0; i<array_length(push_bodies); i++) {
        var body = push_bodies[i];
        with(body) {
            var _pspd = g.convert(other.dx, other.dy, global.g);
            var contact = move_contact_x(_pspd.x, obj_block, true);
            if contact != noone && contact != f.floor.inst {
                squash_block(_pspd.x, _pspd.y);
            }
            contact = move_contact_y(_pspd.y, obj_block, true, true);
            if contact != noone {
                // See if we can move out of the way of the block.
                if do_lateral_squish(-_pspd.y, true) == noone {
                    contact = move_contact_y(_pspd.y, obj_block, true, true);
                }
            }
            if contact != noone {
                squash_block(_pspd.x, _pspd.y);
            }
        }
    }
    
    for (var i = 0; i<array_length(wall_bodies); i++) {
        var body = wall_bodies[i];
        with(body) {
            var _pspd = g.convert(other.dx, other.dy, global.g);
            if sign(face) != sign(_pspd.x) {
                move_contact_x(_pspd.x + sign(_pspd.x), obj_block); // Only move x if it is moving away from the block.
            }
        }
    }
    
    
    
    do_move()
    
    floor_update_coords()
    
    
    for (var i = 0; i<array_length(push_bodies); i++) {
        var body = push_bodies[i];
        with(body) {
            var _pspd = g.convert(other.dx, other.dy, global.g);
            if abs(_pspd.x) > 1.0 {
                // Move back into the block, but only if the block is moving fast enough.
                move_contact_x(-abs(_pspd.x-1.0)*sign(_pspd.x), obj_block, true);
            } 
            move_contact_y(-_pspd.y, obj_floor);
        }
    }
    
    for (var i = 0; i<array_length(wall_bodies); i++) {
        var body = wall_bodies[i];
        with(body) {
            var _pspd = g.convert(other.dx, other.dy, global.g);
            if sign(face) == sign(_pspd.x) {
                move_contact_x(_pspd.x, obj_block, true);
            } else {
                move_contact_x(-_pspd.x, obj_block, true);
            }
        }
    }
    
    for (var i = 0; i<array_length(floor_bodies); i++) {
        var body = floor_bodies[i];
        with(body) {
            var _pspd = g.convert(other.dx, other.dy, global.g);
            if sign(face) == sign(_pspd.x) {
                move_contact_x(_pspd.x, obj_block);
            } 
            if _pspd.y > 0 {
                move_contact_y(_pspd.y, obj_floor, true, true);
            }
        }
    }
}


