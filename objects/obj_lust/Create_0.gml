state_idle = 0
state_telegraph = 1
state_switch = 2
state_spawn = 3



state = new_state(state_idle);

enraged = false

spr_hair = spr_lust_hair

hp = new_hp(4, 180, function(){
    create_sfx(snd_boss_damage, x, y)
    if hp.current == 2 {
        instance_create_depth(x-12, y-12, depth - 1, obj_part_grow, {
            sprite_index: spr_lust_heart,
            image_blend: C_RED,
            lifetime: 64,
        })
        instance_create_depth(x+16, y-16, depth - 1,  obj_part_grow, {
            sprite_index: spr_lust_heart,
            image_blend: C_RED,
            scale: 0.75,
            lifetime: 64,
        })
        enraged = true
        sprite_index = spr_lust_enraged
        spr_hair = spr_lust_hair_enraged
        create_sfx(snd_lust_enrage)
        
    }
})

obj_control.boss_hp = hp

image_index = 0
image_speed = 0


angle_increment = [1, 2, 1, 2, 3, 2]
angle_index = 0

angle = 270;
g = new Gravity(global.g.mag, angle)
current = gravity_down

function lust_set_target() {
    var delta = angle_increment[angle_index] * 90;
    angle_index = (angle_index + 1 ) % array_length(angle_increment);
    angle = (angle + delta) % 360;
    create_sfx(snd_lust_switch)
}

function lust_trigger_target() {
    
    g.update_direction(angle)
    
    current.y = -room_height
    switch(angle) {
        case 0:
            current = gravity_right;
            break;
        case 90:
            current = gravity_up;
            break;
        case 180:
            current = gravity_left;
            break;
        case 270:
            current = gravity_down;
            break;
    }
    current.y = room_height/2;
    
    
}


function lust_spawn_blocks() {
    if hp.current <= 0 {
        return
    }
    var _x = room_width/2 - (g.x * room_width/3);
    var _y = room_height/2 - (g.y * room_height/3);
    
    var _do_center = false;
    
    if abs(g.y) != 0 && abs(obj_hero.x - room_width/2) < room_width/4 {
        _do_center = true;
    }
    if abs(g.x) != 0 && abs(obj_hero.y - room_height/2) < room_height/4 {
        _do_center = true;
    }
    
    var _xoff = (abs(g.y) * (room_width-16)/3) 
    var _yoff = (abs(g.x) * (room_height-16)/3)
    
    if _do_center {
        instance_create_mblocks(_x, _y, obj_breakable_block_summon, {
            xaccel: g.x*g.mag*0.5, 
            yaccel: g.y*g.mag*0.5,
            image_xscale: 1.0 + abs(g.y) * (0.5) * (0.5 + ceil(2-hp.current/2)),
            image_yscale: 1.0 + abs(g.x) * (0.5) * (0.5 + ceil(2-hp.current/2)),
            collision_obj: obj_block,
        }) 
    } else {
        
        instance_create_mblocks(_x - _xoff, _y - _yoff, obj_breakable_block_summon, {
            xaccel: g.x*g.mag*0.5, 
            yaccel: g.y*g.mag*0.5,
            image_xscale: 1 + abs(g.y) * (0.5) * ceil(2-hp.current/2),
            image_yscale: 1 + abs(g.x) * (0.5) * ceil(2-hp.current/2),
            collision_obj: obj_block,
        }) 
        instance_create_mblocks(_x + _xoff, _y + _yoff, obj_breakable_block_summon, {
            xaccel: g.x*g.mag*0.5, 
            yaccel: g.y*g.mag*0.5,
            image_xscale: 1 + abs(g.y) * (0.5) * ceil(2-hp.current/2),
            image_yscale: 1 + abs(g.x) * (0.5) * ceil(2-hp.current/2),
            collision_obj: obj_block,
        }) 
    }
    
    if enraged {
        var _ax = room_width/2 + (g.x * room_width/2);
        var _ay = room_height/2 + (g.y * room_height/2);
        var _xw = max((abs(g.y) * (room_width-32)/3)/16, 1)
        var _yw = max((abs(g.x) * (room_height-32)/3)/16, 1)
        _xoff = (abs(g.y) * (room_width-32)/3) 
        _yoff = (abs(g.x) * (room_height-32)/3)
        
        instance_create_mblocks(_ax, _ay, obj_breakable_block_summon, {
            xaccel: -g.x*g.mag*0.25, 
            yaccel: -g.y*g.mag*0.25,
            image_xscale: _xw,
            image_yscale: _yw,
            collision_obj: obj_block,
        })
        instance_create_mblocks(_ax - _xoff, _ay - _yoff, obj_breakable_block_summon, {
            xaccel: -g.x*g.mag*0.25, 
            yaccel: -g.y*g.mag*0.25,
            image_xscale: _xw,
            image_yscale: _yw,
            collision_obj: obj_block,
        }) 
        instance_create_mblocks(_ax + _xoff, _ay + _yoff, obj_breakable_block_summon, {
            xaccel: -g.x*g.mag*0.25, 
            yaccel: -g.y*g.mag*0.25,
            image_xscale: _xw,
            image_yscale: _yw,
            collision_obj: obj_block,
        }) 
    }
}