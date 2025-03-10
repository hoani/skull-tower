#macro B_IDLE "IDLE"
#macro B_RUN "RUN"
#macro B_JUMP "JUMP"
#macro B_HANG "HANG"
#macro B_WALL "WALL"
#macro B_DASH "DASH"
#macro B_ATTACK "ATTACK"

#macro F_LEFT (-1)
#macro F_RIGHT (1)





function body_update(cmds) {
    update_gravity();
    body_update_frames()
    var had_floor = (f.floor.inst != noone);
    body_update_speed(cmds);
    body_update_movement();
    if f.floor.inst == noone && had_floor {
        jump.coyote = jump.coyote_count;
    }
    body_update_state();   
}

function body_update_frames() {
    f.roof = check_collision_roof()
    set_floor_frame(check_collision_floor())
    update_wall_frames()
    if f.hang != noone {
        if f.hang != f.wall.left && f.hang != f.wall.right {
            f.hang = noone;
        }
    }
}

function accelerate_x(_face) {
    if _face == 0 {
        return;
    }
    var _accel = (f.floor.inst == noone) ? lateral.air.accel : lateral.floor.accel;
    var _max = (f.floor.inst == noone) ? lateral.air.max : (1 - _face*slip_factor*f.floor.ssin)*lateral.floor.max;
    
    if (_face == F_LEFT && f.wall.left != noone) || (_face == F_RIGHT && f.wall.right != noone) {
        _accel = 0;
        if f.floor.inst == noone && sign(spd.x) == _face {
            spd.x = 0    
        }    
    }

    var _spd = spd.x + _face*_accel;
    if abs(_spd) <= _max || abs(_spd) < abs(spd.x) {
        spd.x = _spd    
    } else if abs(_spd) > _max && abs(spd.x) < _max {
        spd.x = sign(_spd) * _max;
    }
    
    if sign(spd.x) == _face && face != _face{
        face = _face;
    }
}


function pressing_into_wall() {
    var _facing_wall = (f.floor.inst == noone) && ((f.wall.left != noone && face == F_LEFT) || (f.wall.right != noone && face == F_RIGHT))
    
    var c = body_collision_point(face*(w_2 + 1), h_2)
    
    return (check_collision_point(c.x, c.y, obj_block) != noone) && _facing_wall
}

function body_jump_common() {
    jump.buffering = 0;
    jump.coyote = 0;    
    jump.wall_coyote = 0;
    create_sfx(x, y, snd_jump)
    instance_create_sfx(x, y, obj_part_fade, {
        scale: 1/2,
        image_angle: irandom(360),
        image_blend: C_WHITE,
    })  
}

function movement_inputs(cmds) {
    var result = {
        pressed: {
            x: 0,
            y: 0,
        },
        held: {
            x: 0,
            y: 0,
        }
    }
    
    if commands_check_pressed(cmds, CMD_LEFT) {
        result.pressed.x -= g.y;
        result.pressed.y -= g.x;
    }
    if commands_check_pressed(cmds, CMD_RIGHT) {
        result.pressed.x += g.y;
        result.pressed.y += g.x;
    }
    if commands_check_pressed(cmds, CMD_DOWN) {
        result.pressed.x -= g.x;
        result.pressed.y += g.y;
    }
    if commands_check_pressed(cmds, CMD_UP) {
        result.pressed.x += g.x;
        result.pressed.y -= g.y;
    }
    
    
    if commands_check(cmds, CMD_LEFT) {
        result.held.x -= g.y;
        result.held.y -= g.x;
    }
    if commands_check(cmds, CMD_RIGHT) {
        result.held.x += g.y;
        result.held.y += g.x;
    }
    if commands_check(cmds, CMD_DOWN) {
        result.held.x -= g.x;
        result.held.y += g.y;
    }
    if commands_check(cmds, CMD_UP) {
        result.held.x += g.x;
        result.held.y -= g.y;
    }
    
    return result
}

    
function body_update_speed(cmds) {
    var had_floor = false;
    if f.floor.inst != noone && spd.y > 0 {
        spd.y = 0;
        had_floor = true;
    }
    if spd.y < 0 && !body_can_move_up() {
        spd.y = 0;
    }
    
    

    dash.cooldown = max(0, dash.cooldown - global.s);
    turn.cooldown = max(0, turn.cooldown - global.s);
    lateral.cooldown = max(0, lateral.cooldown - global.s);
    attack.buffering = max(0, attack.buffering - global.s);
    
    var movement = movement_inputs(cmds);
    y_drop = (movement.held.y > 0);
    
    if f.hang != noone && y_drop {
        f.hang = noone;
    }
    
    if movement.pressed.x != face && movement.pressed.x != 0 {
        face = movement.pressed.x
        if f.floor.inst != noone || f.wall.pressing {
            turn.cooldown = turn.floor_cooldown // Turning on the floor or pushing off wall.
        } else {
            turn.cooldown = turn.air_cooldown // Lower cooldown in the air.
        }
        
        
        if f.hang != noone {
            f.hang = noone;
        }
    }
    
    var x_accel = 0;
    if dash.cooldown == 0 && lateral.cooldown == 0 && turn.cooldown == 0 {
        x_accel = movement.held.x
    }
    
    if commands_check_pressed(cmds, CMD_A) {
        attack.buffering = attack.buffering_count;
    }
    
    if attack.buffering != 0 && dash.cooldown == 0 {
        if command_attack() {
            attack.buffering = 0;
        }
    }
    
    if commands_check(cmds, CMD_B) && dash.cooldown == 0 {
        dash.target = clamp(dash.target + global.s, dash.min, dash.max);
    }
    
    if commands_check_released(cmds, CMD_B) && dash.cooldown == 0  {
        dash.trigger = true;    
    }
    
    if f.floor.inst != noone {
        var _slip = -slip*f.floor.ssin
        if (sign(_slip) == F_LEFT && f.wall.left == noone) || (sign(_slip) == F_RIGHT && f.wall.right == noone) {
            spd.x += _slip*global.s;
        }
    }
    
    apply_body_friction(x_accel)
    
    
    accelerate_x(x_accel);
    
    if (sign(x_accel) == face || abs(spd.x) > 0.75 || f.wall.pressing) {
        var _pressing_prev = f.wall.pressing;
        f.wall.pressing = pressing_into_wall();
        if _pressing_prev && !f.wall.pressing {
            if spd.y > 0 {
                spd.y = 0
                jump.wall_coyote = jump.wall_coyote_count
            }
        }
    }
    
    if commands_check_pressed(cmds, CMD_JUMP) {
        jump.buffering = jump.buffering_count;
    }
    
    if jump.buffering != 0 && dash.cooldown == 0 && attack.state.current == ATTACK_NONE {
        jump.buffering = max(0, jump.buffering - global.s);
        
        if (f.floor.inst != noone || jump.coyote > 0) {
            spd.y = -jump.start_speed * f.floor.scos;
            spd.x += -jump.start_speed * f.floor.ssin;
            body_jump_common() 
        } else if (f.hang != noone) {
            spd.y = -jump.hang_speed;
            spd.x = 0;
            f.hang = noone;
            body_jump_common() 
        } else if (f.wall.pressing) {
            spd.y = -jump.start_speed;
            spd.x = -face * jump.start_speed * jump.wall_factor;
            face = -face
            lateral.cooldown = lateral.wallkick_cooldown;
            body_jump_common() 
        } else if (jump.wall_coyote > 0) {
            spd.y = -jump.start_speed;
            spd.x = face * jump.start_speed * jump.wall_factor;
            lateral.cooldown = lateral.wallkick_cooldown;
            body_jump_common() 
        } else if jump.double && spd.y >= 0 && double_jump_check() {
            spd.y = -jump.double_speed;
            jump.double = false;
            body_jump_common() 
        }
    }
    if jump.coyote > 0 {
        jump.coyote = max(0, jump.coyote - global.s);
    }
    if jump.wall_coyote > 0 {
        jump.wall_coyote = max(0, jump.wall_coyote - global.s);
    }
    

    if f.wall.pressing || spd.y < 0 {
        var _jump_factor = 1.0;
            if abs(spd.y) < 0.25 {
                _jump_factor = 0.5;
            }
        
        if (spd.y > 0 || !commands_check(cmds, CMD_JUMP)) && attack.state.current == ATTACK_NONE && !jump.auto_boost {
            jump.auto_boost = false;
            body_apply_gravity(jump.drop_factor*_jump_factor);
        } else {
            body_apply_gravity(_jump_factor);
        }
    } else {
        body_apply_gravity();
    }
}

function apply_body_friction(x_accel) {
    var on_floor = instance_exists(f.floor.inst);
    
    var apply = (sign(x_accel) != sign(spd.x) && lateral.cooldown == 0)
    apply |= on_floor
    apply |= turn.cooldown != 0
    
    // When on the floor, we always apply friction. When we are in the air, we only apply it when there's no input
    if abs(spd.x) > 0 && apply {
        var _delta = on_floor ? lateral.floor.frict * abs(f.floor.scos) : lateral.air.decel;
        if abs(spd.x) < _delta {
            spd.x = 0;
        } else {
            spd.x -= sign(spd.x)*_delta;
        }
    }
}


function double_jump_check() {
    // Check there's no imminent wall collision.
    var dx0 = 0;
    var dx1 = (spd.x*jump.buffering);
    var c = body_collision_coords(dx0, 0, dx1, 0)
    
    return check_collision_line(c.x0, c.y0, c.x1, c.y1, obj_block) == noone
}

// used to verify whether we set our y speed to zero.
function body_can_move_up() {
    if f.roof == noone {
        return true
    }
    return check_lateral_squish(-1, -lateral.squish) == noone || check_lateral_squish(-1, lateral.squish) == noone
}


function body_update_state() {
    if dash.cooldown != 0 {
        state_set(state, B_DASH);
        return
    }
    
    if attack.state.current != ATTACK_NONE {
        state_set(state, B_ATTACK);
        return
    }
    
    if f.floor.inst == noone {
        if f.hang != noone {
            state_set(state, B_HANG);  
        } else if f.wall.pressing {
            state_set(state, B_WALL);
        } else {
            state_set(state, B_JUMP);
        }
        return;
    }
    
    // Landing particles.
    if state.current == B_JUMP {
        instance_create_sfx(x-4, y+4, obj_part_fade, {
            scale: 1/2,
            image_angle: irandom(360),
            image_blend: C_WHITE,
            lifetime: 24,
            yspd: -0.125,
        })
        instance_create_sfx(x+4, y+4, obj_part_fade, {
            scale: 1/2,
            image_angle: irandom(360),
            image_blend: C_WHITE,
            lifetime: 24,
            yspd: -0.125,
        }) 
    }
    
    if spd.x != 0  {
        state_set(state, B_RUN);
        
        instance_create_sfx(x, y+4, obj_part_fade, {
            scale: 1/4,
            image_angle: irandom(360),
            image_blend: C_WHITE,
        }) 
    } else {
        state_set(state, B_IDLE);
    }
    
}

function body_apply_gravity(factor=1) {
    if f.floor.inst == noone && f.hang == noone {
        var accel = g.mag*factor* global.s;
        var y_spd_max = term_velocity;
        if f.wall.pressing {
            y_spd_max = wall_term_velocity;
        }
        if spd.y > 0 {
            accel *= f.wall.pressing ? wall_friction_factor : 1.0;
        }
        spd.y += accel
            
        if spd.y > y_spd_max {
            spd.y = y_spd_max;
        }
    }
}

function body_move(_dx, _dy, _update_gravity=true) {
    x += g.y * _dx + g.x * _dy;
    y += g.y * _dy - g.x * _dx;
    x = clamp(x, w_2, room_width - w_2)
    update_excludes();
    if _update_gravity {
        update_gravity();
    }
}

function body_collision_coords(dx0, dy0, dx1, dy1) {
    return {
        x0: x + g.y*(dx0) + g.x*(dy0),
        y0: y + g.y*(dy0) - g.x*(dx0),
        x1: x + g.y*(dx1) + g.x*(dy1),
        y1: y + g.y*(dy1) - g.x*(dx1),
    }
}

function body_collision_point(dx0, dy0) {
    return {
        x: x + g.y*(dx0) + g.x*(dy0),
        y: y + g.y*(dy0) - g.x*(dx0),
    }
}

function check_collision_roof() {
    var _dx = (w_2-1);
    var _dy = -(h_2+1);
    var c = body_collision_coords(-_dx, _dy, _dx, _dy)
    return check_collision_line(c.x0, c.y0, c.x1, c.y1, obj_block, f.excludes, f.roof)
}

function check_collision_floor() {
    if spd.y < 0 {
        return noone;
    }
    var _dx = (w_2-1);
    var _dy = h_2+0.5;
    var c = body_collision_coords(-_dx, _dy, _dx, _dy)
    return check_collision_line(c.x0, c.y0, c.x1, c.y1, obj_floor, f.excludes, f.floor.inst)
}

function update_wall_frames() {
    var dx0 = w_2;
    var dy0 = h_2-step_height.floor;
    var dy1 = -(h_2-1);
    var c = body_collision_coords(-dx0, dy0, -(dx0+1), dy1);
    f.wall.left = check_collision_rectangle(c.x0, c.y0, c.x1, c.y1, obj_block, f.excludes, f.wall.left);
    c = body_collision_coords(dx0, dy0, dx0+1, dy1);
    f.wall.right = check_collision_rectangle(c.x0, c.y0, c.x1, c.y1, obj_block, f.excludes, f.wall.right);
}
    
function body_update_movement() {
    
    update_excludes(); // Need to update excludes at least once, even if not moving.
    
    if y_drop && instance_exists(f.floor.inst) {
        move_contact_y(1, obj_block)
    }
    
    base_lateral_update(spd.x, spd.y);
    
    var spdx = dx;
    var spdy = dy;
    show_debug_message($" pos ({x},{y}) spd ({spd.x}, {spd.y}) d ({dx}, {dy})")
    move_contact_x(spdx, obj_block);
    
    if spdy > 0 {
        var _dx = (w_2*1.5)*face;
        var _dy = -h_2;
        var c = body_collision_point(_dx, _dy);    
        var hang_candidate = face == F_LEFT ? f.wall.left : f.wall.right;
        var hang_start = collision_point(c.x, c.y, obj_block, true, true);
        set_floor_frame(move_contact_y(spdy, obj_floor, true, false))
        f.roof = check_collision_roof()
        c = body_collision_point(_dx, _dy); 
        if !hang_start && collision_point(c.x, c.y, hang_candidate, true, true) {
            f.hang = hang_candidate;
            spd.y = 0;
            move_to_hang(-spdy, f.hang);
        }
    } else if spdy < 0 {
        f.roof = move_contact_y(spdy, obj_block, true, true)
        set_floor_frame(check_collision_floor())
    } else {
        f.roof = check_collision_roof()
        set_floor_frame(check_collision_floor())
    }
    update_wall_frames();
    
    calculate_dash()
    
    if dash.trigger {
        do_dash()
    }
    
    if f.floor.inst != noone {
        jump.double = true;
    }
}

function do_dash() {
    if dash.distance >= 4 {
        hero_create_after_shadow()
        face = dash.face;
        x = dash.x;
        y = dash.y;
        dash.cooldown = dash.cooldown_count;
        create_sfx(x, y, snd_dash)
    }
    dash.trigger = false;
    dash.target = 0;
    dash.distance = 0;
}

function calculate_dash() {
    var _face = face;
    var dx0 = 0;
    var dx1 = _face*(dash.target + w_2);
    var dy0 = -h_2;
    var dy1 = h_2;
    var c = body_collision_coords(dx0, dy0, dx1, dy1)
    
    var def = body_collision_point(_face*dash.target, 0);
    dash.x = def.x;
    dash.y = def.y;
    dash.face = _face;
    
    var list = ds_list_create();
    var num = collision_rectangle_list(c.x0, c.y0, c.x1, c.y1, [obj_block, obj_dash_barrier], true, true, list, false);
    dash.distance = dash.target;
    for (var i = 0; i < num; i++){
        var candidate = ds_list_find_value(list, i);
        if !array_contains(f.excludes, candidate) {
            pos = get_block_contact(x, y, g.dir, _face, candidate);
            if point_distance(x, y, pos.x, pos.y) < dash.distance {
                dash.x = pos.x;
                dash.y = pos.y;
                dash.distance = point_distance(x, y, pos.x, pos.y);
            }
        }
    }
    ds_list_destroy(list);
}

function check_hang(_inst) {
    var _dx = (w_2*1.5)*face;
    var _dy = -h_2;
    var c1 = body_collision_point(_dx, _dy);    
    var c2 = body_collision_point(_dx, _dy-1);
    return collision_point(c1.x, c1.y, _inst, true, true) && !collision_point(c2.x, c2.y, obj_block, true, true);
}


function move_contact_x(_dx, obj, forcex=false, with_stepping=true) {
    var dist = 0;
    var delta = min(_dx, width); // If dx > width, we cap delta to avoid clipping through walls.
    var inst = noone;
    
    if _dx == 0 {
        return noone;
    }
    
    var sx = 1.0;
    var sy = 0.0;
    if abs(f.floor.scos) > 1/4 {
        sx = f.floor.scos;
        sy = -sign(_dx)*f.floor.ssin;
        if forcex {
            sy = sy/sx;
            sx = 1.0;
        }
    } else {
        sy = 0 // Treat slope as a wall.
    }
    
    while(dist < abs(_dx)) {
        var dx0 = sign(delta) < 0 ? floor(delta*sx) : ceil(delta*sx);
        var dx1 = dx0 + w_2*sign(delta);
        var dy0 = -h_2 + abs(delta)*sy;
        var dy1 = dy0 + height;
        var c = body_collision_coords(dx0, dy0, dx1, dy1)
        inst = check_collision_rectangle(c.x0, c.y0, c.x1, c.y1, obj, f.excludes) 
        if inst == noone {
            body_move(delta*sx, abs(delta)*sy)
            if forcex {
                dist += abs(delta)*point_distance(0, 0, sx, sy);
            } else {
                dist += abs(delta);
            }
            continue;
        }
        // Check step logic, but only if the slope isn't steeper than 30 deg.
        if floor_is_steppable() {
            var _step_height = f.floor.inst == noone ? step_height.air : step_height.floor;
            dy0 = dy0 + -_step_height;
            dy1 = dy1 + -_step_height;
            c = body_collision_coords(dx0, dy0, dx1, dy1);
            var inst2 = check_collision_rectangle(c.x0, c.y0, c.x1, c.y1, obj, f.excludes)
            if inst2 == noone {
                inst = noone;
                body_move(delta*sx, abs(delta)*sy - _step_height)
                if forcex {
                    dist += abs(delta)*point_distance(0, 0, sx, sy);
                } else {
                    dist += abs(delta);
                }
                set_floor_frame(move_contact_y(_step_height, obj_floor))
                if abs(f.floor.scos) > 1/4 {
                    sx = f.floor.scos;
                    sy = -sign(_dx)*f.floor.ssin;
                    if forcex {
                        sy = sy/sx;
                        sx = 1.0;
                    }
                } else {
                    sx = 1
                    sy = 0 // Treat slope as a wall.
                }
                continue;
            }
        }
        if abs(delta) == 1.0 {
            break;
        }
        delta = sign(delta)*ceil(abs(delta/2.0));
    }
    
    if global.debug {
        show_debug_message($"floor_angle {f.floor.slope} sx, sy ({sx}, {sy}) spd ({spd.x}, {spd.y}), moved {dist}")
    }
    
    // Prevent jumping when reaching corners of slopes.
    if f.floor.slope != 0 {
        var _floor = check_collision_floor();
        if _floor == noone {
            set_floor_frame(move_contact_y(abs(_dx), obj_floor))
        }
    }
    
    return inst
}

function floor_is_steppable() {
    if (f.floor.inst == noone) {
        return true
    }

    return (abs(f.floor.slope) <= 30.0);
}


function move_contact_y(_dy, obj, _update_gravity=true, _with_squish=false) {
    if abs(_dy) == 0.0 {
        return noone
    }
    var dist = 0;
    var delta = _dy;
    var inst = noone;
    while(dist < abs(_dy)) {
        var dx0 = - (w_2);
        var dx1 = w_2;
        var dy0 = h_2*sign(delta);
        var dy1 = dy0 + delta;
        var c = body_collision_coords(dx0, dy0, dx1, dy1)
        var current = _dy > 0 ? f.floor.inst : f.roof; // Provide the current floor or roof for the collision rectangle.
        inst = check_collision_rectangle(c.x0, c.y0, c.x1, c.y1, obj, f.excludes, current) 
        if inst == noone {
            body_move(0, delta, _update_gravity)
            dist += abs(delta);
        } else {
            if _with_squish && delta < 0 {
                inst = do_lateral_squish(delta, _update_gravity)
                if inst == noone {
                    show_debug_message("did squish")
                    dist += abs(delta);
                }
            }
            
            if abs(delta) == 1.0 {
                break;
            }
            delta = sign(delta)*ceil(abs(delta/2.0));
        }
    }
    return inst
}


function do_lateral_squish(delta, _update_gravity=true) {
    var inst = check_lateral_squish(delta, -lateral.squish)
    if inst == noone {
        body_move(-lateral.squish, delta, _update_gravity)
        move_contact_x(lateral.squish, obj_block, false, false)
        return noone
    }
    inst = check_lateral_squish(delta, lateral.squish)
    if inst == noone {
        body_move(lateral.squish, delta, _update_gravity)
        move_contact_x(-lateral.squish, obj_block, false, false)
        return noone
    }
    return inst
}


function check_lateral_squish(_dy, _dx) {
    if abs(_dy) == 0.0 {
        return noone
    }

    var dx0 = -(w_2) + _dx;
    var dx1 = w_2 + _dx;
    var dy0 = h_2*sign(_dy);
    var dy1 = dy0 + _dy;
    var c = body_collision_coords(dx0, dy0, dx1, dy1)
    var current = _dy > 0 ? f.floor.inst : f.roof; // Provide the current floor or roof for the collision rectangle.
    return check_collision_rectangle(c.x0, c.y0, c.x1, c.y1, obj_block, f.excludes, current) 
}

function move_to_hang(_dy, hang_candidate) {
    if abs(_dy) == 0.0 {
        return
    }
    
    if g.dir == 270 { 
        y = min(hang_candidate.y0, hang_candidate.y1, hang_candidate.y2, hang_candidate.y3) + h_2;
    } else if g.dir == 90 {
        y = max(hang_candidate.y0, hang_candidate.y1, hang_candidate.y2, hang_candidate.y3) - h_2; 
    } else if g.dir == 0 {
        x = min(hang_candidate.x0, hang_candidate.x1, hang_candidate.x2, hang_candidate.x3) + w_2;
    } else {
        x = max(hang_candidate.x0, hang_candidate.x1, hang_candidate.x2, hang_candidate.x3) - w_2;
    }
    update_excludes();
}


function update_excludes() {
    var _dx = w_2-1;
    var _dy = h_2-1;
    var c = body_collision_coords(-_dx, -_dy, _dx, _dy)
    var list = ds_list_create();
    var num = collision_rectangle_list(c.x0, c.y0, c.x1, c.y1, obj_floor, true, true, list, false);
    f.excludes = [];
    for (var i = 0; i < num; i++) {
        var item = ds_list_find_value(list, i);
        array_push(f.excludes, ds_list_find_value(list, i));
    }
    ds_list_destroy(list);
}

function update_gravity() {
    var gPrev = new Gravity(g.mag, g.dir);
    var gy_prev = g.y;
    if f.grav != noone {
        if !position_meeting(x, y, f.grav) {
            f.grav = noone;
        }
    }
    if f.grav == noone {
        f.grav = collision_point(x, y, obj_gravity_field, false, true);
    }
    if instance_exists(f.grav) {
        g.update_direction(f.grav.gdir);
    } else {
        g.update_direction(global.g.dir); // default.
    }
    
    if gPrev.dir != g.dir {
        f.hang = noone
        image_angle = (g.dir + 90 % 360)
        yspdPrev = spd.y
        spd = g.convert(spd.x, spd.y, gPrev);
        if yspdPrev >= 0 { // This check is essential to make sure we don't move in and out of a gravity field.
            move_contact_y(-h_2, obj_floor, false); 
            move_contact_y(h_2, obj_floor, false);
        }
    }
    
    delete gPrev;
}

function check_collision_rectangle(x0, y0, x1, y1, obj, excludes=[], current=noone) {
    var list = ds_list_create();
    var num = collision_rectangle_list(x0, y0, x1, y1, obj, true, true, list, false);
    var result = noone;
    for (var i = 0; i < num; i++){
        var candidate = ds_list_find_value(list, i);
        if !array_contains(excludes, candidate) {
            result = candidate;
            if candidate == current || current == noone {
                break;
            }
        }
    }
    ds_list_destroy(list);
    return result;
}


function check_collision_line(x0, y0, x1, y1, obj, excludes=[], current=noone) {
    var list = ds_list_create();
    var num = collision_line_list(x0, y0, x1, y1, obj, true, true, list, false);
    var result = noone;
    for (var i = 0; i < num; i++){
        var candidate = ds_list_find_value(list, i);
        if !array_contains(excludes, candidate) {
            result = candidate;
            if candidate == current || current == noone {
                break;
            }
        }
    }
    ds_list_destroy(list);
    return result;
}

function check_collision_point(x0, y0, obj, excludes=[], current=noone) {
    var list = ds_list_create();
    var num = collision_point_list(x0, y0, obj, true, true, list, false);
    var result = noone;
    for (var i = 0; i < num; i++){
        var candidate = ds_list_find_value(list, i);
        if !array_contains(excludes, candidate) {
            result = candidate;
            if candidate == current || current == noone {
                break;
            }
        }
    }
    ds_list_destroy(list);
    return result;
}

function set_floor_frame(inst) {
    f.floor.inst = inst;
    if instance_exists(inst) {
        f.floor.slope = inst.floor_angle(x, y, width, g.dir);
    } else {
        f.floor.slope = 0;
    }
    f.floor.scos = dcos(f.floor.slope);
    f.floor.ssin = dsin(f.floor.slope);
}

function body_squash_floor(xspd, yspd) {
    show_debug_message($"squash floor ({xspd}, {yspd})")    
}

function body_squash_block(xspd, yspd) {
    show_debug_message($"squash block ({xspd}, {yspd})")    
} 

