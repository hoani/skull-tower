

// Note:
// Angled moving blocks are not supported, the challenges with angled moving blocks would require a different
// platforming engine since the pushing of bodies isn't really using any physics principles.

function moving_floor_update() {
    floor_bodies = [];
    push_bodies = [];
    // Collect all candidates.
    with (obj_body) {
        var _pspd = g.convert(other.xspd, other.yspd, global.g);
        if f.floor.inst == other.id {
            array_push(other.floor_bodies, id);
        } else if _pspd.y < 0 && place_meeting(x - other.xspd, y - other.yspd, other.id) && !place_meeting(x, y, other.id)  {
            array_push(other.push_bodies, id);
        }
        if place_meeting(x - other.xspd, y - other.yspd, other.id) {
            show_debug_message($"block colliding ${place_meeting(x, y, other.id)}")
        }
    }
    
    
    for (var i = 0; i<array_length(floor_bodies); i++) {
        var body = floor_bodies[i];
        with(body) {
            var _pspd = g.convert(other.xspd, other.yspd, global.g);
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
            var _pspd = g.convert(other.xspd, other.yspd, global.g);
            var contact = move_contact_y(_pspd.y, obj_block);
            if contact != noone {
                squash_floor(_pspd.x, _pspd.y);
            }
        }
    }
    
    
    
    x += xspd;
    if x > room_width {
        x = 0;
    }
    
    if x < 0 {
        x = room_width;
    }
    
    y += yspd;
    if y > room_height {
        y = 0;
    }
    
    if y < 0 {
        y = room_height;
    }
    
    floor_update_coords()
    
    
    for (var i = 0; i<array_length(push_bodies); i++) {
        var body = push_bodies[i];
        with(body) {
            var _pspd = g.convert(other.xspd, other.yspd, global.g);
            move_contact_y(-_pspd.y, obj_floor);
        }
    }
    
    for (var i = 0; i<array_length(floor_bodies); i++) {
        var body = floor_bodies[i];
        with(body) {
            var _pspd = g.convert(other.xspd, other.yspd, global.g);
            move_contact_x(_pspd.x, obj_block);
            if _pspd.y > 0 {
                move_contact_y(_pspd.y, obj_floor);
            }
        }
    }
}

function moving_block_update() {
    floor_bodies = [];
    push_bodies = [];
    wall_bodies = [];
    // Collect all candidates.
    with (obj_body) {
        var _pspd = g.convert(other.xspd, other.yspd, global.g);
        if f.floor.inst == other.id || f.hang == other.id {
            array_push(other.floor_bodies, id);
        } else if (f.wall.left == other.id || f.wall.right == other.id) && sign(spd.x) == sign(_pspd.x) && abs(spd.x) > abs(_pspd.x) {
            array_push(other.wall_bodies, id);
        } else if place_meeting(x - other.xspd, y - other.yspd, other.id) && !place_meeting(x, y, other.id)  {
            array_push(other.push_bodies, id);
        }
    }
    
    for (var i = 0; i<array_length(floor_bodies); i++) {
        var body = floor_bodies[i];
        with(body) {
            var _pspd = g.convert(other.xspd, other.yspd, global.g);
            if sign(face) != sign(_pspd.x) {
                move_contact_x(_pspd.x, obj_block); // Only move x if it is moving away from the block.
            }
            if _pspd.y < 0 {
                var contact = move_contact_y(_pspd.y, obj_block);
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
            var _pspd = g.convert(other.xspd, other.yspd, global.g);
            var contact = move_contact_x(_pspd.x, obj_block, true);
            if contact != noone && contact != f.floor.inst {
                squash_block(_pspd.x, _pspd.y);
            }
            contact = move_contact_y(_pspd.y, obj_floor);
            if contact != noone && contact != f.floor.inst {
                squash_block(_pspd.x, _pspd.y);
            }
        }
    }
    
    
    
    x += xspd;
    if x > room_width {
        x = 0;
    }
    
    if x < 0 {
        x = room_width;
    }
    
    y += yspd;
    if y > room_height {
        y = 0;
    }
    
    if y < 0 {
        y = room_height;
    }
    
    floor_update_coords()
    
    
    for (var i = 0; i<array_length(push_bodies); i++) {
        var body = push_bodies[i];
        with(body) {
            var _pspd = g.convert(other.xspd, other.yspd, global.g);
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
            var _pspd = g.convert(other.xspd, other.yspd, global.g);
            move_contact_x(_pspd.x, obj_block, true);
        }
    }
    
    for (var i = 0; i<array_length(floor_bodies); i++) {
        var body = floor_bodies[i];
        with(body) {
            var _pspd = g.convert(other.xspd, other.yspd, global.g);
            if sign(face) == sign(_pspd.x) {
                move_contact_x(_pspd.x, obj_block);
                show_debug_message("hang moving") 
            } 
            if _pspd.y > 0 {
                move_contact_y(_pspd.y, obj_floor);
            }
        }
    }
}

