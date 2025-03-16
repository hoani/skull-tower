state_scan = 0;
state_telegraph = 1;
state_spawn = 2;
state_scan_big_block = 3;
state_telegraph_big_block = 4;
state_spawn_big_block = 5;
state_scan_hands = 6;
state_telegraph_hands = 7;
state_drop_hands = 8;
state_return_to_scan = 9;

enraged = false
spr_hands = spr_greed_hands

state = new_state(state_scan);

hp = new_hp(4, 120, function(){
    create_sfx(snd_boss_damage, x, y)
    if hp.current == 2 {
        create_sfx(snd_enrage, x, y)
        enraged = true
        sprite_index = spr_greed_enraged
        spr_hands = spr_greed_hands_enraged
    }
})

return_spd = 3;

obj_control.boss_hp = hp

image_index = 0
image_speed = 0

hands_image = 0;

spawn_count = 0;
spawn_dir = 1;
spawn_x = -24;

spawn_patterns = [
    [44, 40, 36, 32],
    [44, 40, 40, 40],
    [36, 40, 56, 40],
    [36, 48, 40, 48],
    [36, 56, 40, 32],
];

spawn_pattern_index = 0;

function greed_spawn_block() {
    var spawn_pattern = spawn_patterns[spawn_pattern_index]
    
    spawn_x += spawn_pattern[spawn_count];
    var _x = spawn_dir == 1 ? room_width - spawn_x : spawn_x ;
    var _y = 32;
    
    spawn_count++
    
    if _x > room_width || _x < 0 {
        return // skip this one
    }
    
    instance_create_mblocks(_x, _y, obj_falling_block_summon, {
        xaccel: 0, 
        yaccel: global.g.mag,
        yspd: 0.0,
        term: 2,
        image_xscale: 1.5,
        image_yscale: 1,
        sprite_index: spr_falling_block_summon_greed,
        summoned_spr: spr_falling_block_greed,
    }) 
    
}

function greed_spawn_big_block() {
    
    var inst = instance_create_mblocks(room_width/2, 16, obj_breakable_block_summon, {
        xaccel: 0, 
        yaccel: global.g.mag*0.5,
        yspd: 0,
        term: 1.5,
        image_xscale: room_width/16,
        image_yscale: 1,
        sprite_index: spr_falling_block_summon_greed,
        summoned_spr: spr_cracked_block_greed,
        c_broken: C_YELLOW,
    }) 
}

function greed_trade_blocks() {
    with(obj_falling_block) {
        instance_destroy()
        instance_create_mblocks(x, y, obj_breakable_block, {
            xaccel: 0, xspd: 0,
            yaccel: global.g.mag, yspd: -(4.5 - 2*abs(x-other.x)/room_width),
            image_xscale: image_xscale,
            image_yscale: image_yscale,
            sprite_index: spr_cracked_block_greed,
            c_broken: C_YELLOW,
        })
    }
}
