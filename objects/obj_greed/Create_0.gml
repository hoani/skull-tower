state_scan = 0;
state_telegraph = 1;
state_spawn = 2;
state_scan_hands = 3;
state_telegraph_hands = 4;
state_drop_hands = 5;



state = new_state(state_scan);

hp = new_hp(5, 120, function(){
    create_sfx(snd_boss_damage, x, y)
})

obj_control.boss_hp = hp

image_index = 0
image_speed = 0

hands_image = 0;

spawn_count = 0;
spawn_dir = 1;
spawn_x = -24;

function greed_spawn_block() {
    spawn_x += (32 + irandom(2)*8);
    var _x = spawn_dir == 1 ? room_width - spawn_x : spawn_x ;
    var _y = 32;
    
    spawn_count++
    
    if _x > room_width || _x < 0 {
        return // skip this one
    }
    
    instance_create_mblocks(_x, _y, obj_falling_block_summon, {
        xaccel: 0, 
        yaccel: global.g.mag,
        yspd: 1.0 - (hp.current/hp.max),
        term: 2.0 + 0.5*(1.0 - hp.current/hp.max),
        image_xscale: 1 + 0.5 * ceil(2*(1.0 - hp.current/hp.max)),
        image_yscale: 1,
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
        })
    }
}
