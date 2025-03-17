state_scan = 0
state_telegraph = 1
state_attack = 2
state_recover = 3;
state_retreat = 4;
state_far_block = 5;
state_far_wait = 6;
state_far_wave = 7;
state_advance = 8;

state = new_state(state_scan);

hp = new_hp(5, 120, function(){
    create_sfx(snd_boss_damage, x, y)
    if hp.current % 2 == 0 {
        pride_switch_to_far_mode()
    } else {
        pride_switch_to_close_mode()
    }
})

obj_control.boss_hp = hp

image_index = 2
image_speed = 0

rw = room_width - 16
xoffset = 8 + rw/8
xincr = rw/4

rh = room_height - 16
yoffset = 8 + rh/8
yincr = rh/4


targetx = xoffset
targety = yoffset


attack_angle = 0;
attack_pos = 0;

posx = [32, 80, 128]
posy = [72, 56, 72]
num_pos = 3;

down = false
left = false
right = false

farx = room_width/2
fary = 24


function pride_switch_to_far_mode() {
    targetx = farx;
    targety = fary;
    state_set(state, state_retreat);
    spawn_cycle = 0;
}

function pride_switch_to_close_mode() {
    pride_set_target()
    state_set(state, state_advance);
    with(obj_falling_block) {
        do_moving_block_break()
    }
    with(obj_wave_pride) {
        instance_destroy()
    }
}

function pride_set_target() {
    down = false
    left = false
    right = false
    
    attack_pos = (attack_pos + 1 + irandom(num_pos - 2)) % num_pos;
    targetx = posx[attack_pos];
    targety = posy[attack_pos];
    
    if hp.current > 4  {
        if attack_pos == 0 {
            if irandom(1) == 0 {
                down = true
            } else {
                right = true
            }
        }
        if attack_pos == 1 {
            if irandom(1) == 0 {
                down = true
            } else {
                left = true
                right = true
            }
        }
        if attack_pos == 2 {
            if irandom(1) == 0 {
                down = true
            } else {
                left = true
            }
        }
    } else if hp.current > 2 {
        if attack_pos == 0 {
            down = true
            right = true
        }
        if attack_pos == 1 {
            if irandom(1) == 0 {
                down = true
                left = true
            } else {
                down = true
                right = true
            }
        }
        if attack_pos == 2 {
            down = true
            left = true
        }
    } else {
        down = true
        left = true
        right = true 
    }
}

pride_set_target()


spd = 4;

rw = room_width - 16
xoffset = 8 + rw/12


bll = xoffset
blr = xoffset + rw/6;
bml = xoffset + 2*rw/6
bmr = xoffset + 3*rw/6
brl = xoffset + 4*rw/6
brr = xoffset + 5*rw/6;


spawn_cycle = 0;
spawn_from_left = true;
spawn_pattern_index = irandom(4);
spawn_patterns = [
    [bll, blr, brl, brr],
    [bll, bml, bmr, brr],
    [blr, brl, bll, brr],
    [bml, bmr, blr, brl],
    [bll, blr, bml],
]

function pride_spawn_block() {
    if spawn_cycle > 3 {
        exit;
    }
    var spawn_pattern = spawn_patterns[spawn_pattern_index]
    
    var _y = -128;
    
    for (var i=0; i<array_length(spawn_pattern); i++) {
        var _x = spawn_from_left ? spawn_pattern[i] : room_width - spawn_pattern[i];
        var inst = instance_create_mblocks(_x, _y-i*64, obj_falling_block, {
            yspd: 2,
            term: 2,
            image_xscale: 1.5,
            image_yscale: 2,
        }) 
    }
    
    
    
    spawn_pattern_index = (spawn_pattern_index + 1)%array_length(spawn_patterns);
    spawn_from_left = !spawn_from_left;
}

wave_left = true

function pride_spawn_wave() {
    
    var _y = max(room_height/2 - spawn_cycle * 16, room_height/2 - 64);
    
    var _x = wave_left ? 0 : room_width
    var _dir = wave_left ? 0 : 180;

    instance_create_obstacles(_x, _y, obj_wave_pride, {
        spd: 1, 
        image_angle: _dir,
        scale: 1,
    })
    
    wave_left = !wave_left
}
