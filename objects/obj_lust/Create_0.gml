state_idle = 0
state_telegraph = 1
state_switch = 2
state_spawn = 3



state = new_state(state_idle);

hp = new_hp(4, 120, function(){
    create_sfx(snd_boss_damage, x, y)
})

obj_control.boss_hp = hp

image_index = 0
image_speed = 0


angle = 270;
g = new Gravity(global.g.mag, angle)
current = gravity_down

function lust_set_target() {
    angle = (angle + 90*(1 + irandom(2))) % 360;
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
    var _x = room_width/2 - (g.x * room_width/4);
    var _y = room_height/2 - (g.y * room_height/4);
    
    var _do_center = false;
    
    if abs(g.y) != 0 && abs(obj_hero.x - room_width/2) < room_width/3 {
        _do_center = true;
    }
    if abs(g.x) != 0 && abs(obj_hero.y - room_height/2) < room_height/3 {
        _do_center = true;
    }
    
    if _do_center {
        instance_create_mblocks(_x, _y, obj_breakable_block_summon, {
             xaccel: g.x*g.mag, 
             yaccel: g.y*g.mag,
             image_xscale: 1 + abs(g.y) * (0.5) * (5-hp.current),
             image_yscale: 1 + abs(g.x) * (0.5) * (5-hp.current),
        }) 
    } else {
        var _xoff = (abs(g.y) * room_width/4)
        var _yoff = (abs(g.x) * room_height/4)
        instance_create_mblocks(_x - _xoff, _y - _yoff, obj_breakable_block_summon, {
            xaccel: g.x*g.mag, 
            yaccel: g.y*g.mag,
            image_xscale: 1 + abs(g.y) * (0.5) * ceil(2-hp.current/2),
            image_yscale: 1 + abs(g.x) * (0.5) * ceil(2-hp.current/2),
        }) 
        instance_create_mblocks(_x + _xoff, _y + _yoff, obj_breakable_block_summon, {
            xaccel: g.x*g.mag, 
            yaccel: g.y*g.mag,
            image_xscale: 1 + abs(g.y) * (0.5) * ceil(2-hp.current/2),
            image_yscale: 1 + abs(g.x) * (0.5) * ceil(2-hp.current/2),
        }) 
    }
}