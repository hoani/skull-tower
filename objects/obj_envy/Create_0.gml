state_scan = 0;
state_teleport = 1;
state_telegraph = 2
state_spawn = 4;
state_cooldown = 5;



state = new_state(state_scan);

hp = new_hp(6, 120, function(){
    create_sfx(snd_boss_damage, x, y)
})

obj_control.boss_hp = hp

image_index = 0
image_speed = 0

targetx = xstart
targety = ystart


pos = 0;

posx = [64, 80, 96]
posy = [28, 32, 28]
num_pos = 3;

down = false
left = false
right = false



function envy_set_position() {
    pos = (pos + 1 + irandom(num_pos - 2)) % num_pos;
    targetx = posx[pos]
    targety = posy[pos]
}

scx = 80
scy = 88

summonx = [scx, scx + 28, scx + 28, scx, scx - 28, scx - 28];
summony = [scy + 32, scy + 16, scy - 16, scy - 32, scy - 16, scy + 16];

spawn_count = 0;
spawn_dir = 1;

function envy_spawn_summon() {
    var index = (spawn_dir*spawn_count + 6) % 6;
    var _x = summonx[index];
    var _y = summony[index];
    
    spawn_count++
    
    if hp.current > 2 {
        spawn_count++
    }
    
    instance_create_mblocks(_x, _y, obj_envy_spike_spawn) 
    
}

