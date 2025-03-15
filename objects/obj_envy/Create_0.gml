state_scan = 0;
state_teleport = 1;
state_telegraph = 2
state_spawn = 4;
state_cooldown = 5;
state_wave_teleport = 6;
state_wave = 7;
state_transform_teleport = 8;
state_transform_wait = 9;
state_transform = 10;

state = new_state(state_telegraph);


hp = new_hp(6, 150, function(){
    create_sfx(snd_boss_damage, x, y)
    
    if hp.current == 3 {
        wave_index = wave_index % 2;
        state_set(state, state_transform_teleport);
        targetx = scx
        targety = scy
    }
})

obj_control.boss_hp = hp

image_index = 0
image_speed = 0

targetx = xstart
targety = ystart


pos = 0;

posx = [72, 80, 88]
posy = [32, 36, 32]
num_pos = 3;

down = false
left = false
right = false

enraged = false

function envy_set_position() {
    pos = (pos + 1 + irandom(num_pos - 2)) % num_pos;
    targetx = posx[pos]
    targety = posy[pos]
}

scx = 80
scy = 88
scr = 24;

summonx = [];
summony = [];

var rad = scr;
for (var i = 0; i < 6; i++) {
    rad = scr * (i % 2 == 0 ? 1: 1.25)
    array_push(summonx, scx + rad*dsin(60*i));
    array_push(summony, scy + rad*dcos(60*i));
}


spawn_count = 0;
spawn_dir = 1;

function envy_spawn_summon() {
    var index = (spawn_dir*spawn_count + 6) % 6;
    var _x = summonx[index];
    var _y = summony[index];
    
    spawn_count++
    
    if hp.current > 3 {
        spawn_count++
    }
    
    instance_create_obstacles(_x, _y, obj_envy_spike_spawn) 
    
}

wave_index = 0;

function envy_emit_wave() {
    create_sfx(snd_emit_wave, scx, scy)
    var angle = wave_index * 60;
    for (var i = 0; i<6; i++) {
        
        instance_create_obstacles(scx, scy, obj_wave_envy, {
            spd: 1, 
            image_angle: angle + i * 60,
            scale: 0.25,
        })

        
        if hp.current > 3 {
            i+=2
        } else {
            i+=1
        }
    } 
    
    wave_index = (wave_index + 1) % 3;
    if hp.current <= 3 {
        wave_index = wave_index % 2;
    }
}

function envy_wave_circle_image() {
    var offset = 2;
    if hp.current <= 3 {
        offset += 3;
    }
    return offset + wave_index;
}

