state_scan = 0
state_telegraph = 1
state_attack = 2
state_recover = 3;
state_transform = 4;

enraged = false;

state = new_state(state_scan);

hp = new_hp(6, 70, function(){
    create_sfx(snd_boss_damage, x, y)
    if hp.current == 3 {
        state_set(state, state_transform);
        sprite_index=spr_wrath_transform
        instance_create_depth(x, y, depth + 1, obj_part_shrink, {
            sprite_index: spr_envy_summon_circle,
            image_blend: C_RED,
            lifetime: 24,   
            scale: 2,
        })
    }
})

obj_control.boss_hp = hp

image_index = 1

rw = room_width - 16
xoffset = 8 + rw/8
xincr = rw/4
rw_max = 3*xincr + xoffset

rh = room_height - 16
yoffset = 8 + rh/8
yincr = rh/4
rh_max = 3*yincr + yoffset


targetx = xoffset
targety = yoffset


do_target_x = false

function wrath_set_target() {
    do_target_x = !do_target_x; // toggle
    if do_target_x || enraged {
        var prev = targetx;
        if instance_exists(obj_hero) {
            targetx = floor(4*obj_hero.x/room_width)*(xincr) + xoffset;
        }
        if targetx == prev {
            targetx = (targetx + xincr);
            if targetx > rw_max {
                targetx = rw_max - xincr;
            }
        }
        if targety > room_height*3/4 {
            targety = yoffset + yincr
        }
        if targety < room_height/4 {
            targety = yoffset + 2*yincr
        }
    } 
    if !do_target_x || enraged {
        var prev = targety;
        if instance_exists(obj_hero) {
            targety = floor(4*(obj_hero.y-16)/rh)*(yincr) + yoffset;
        }
        if targety == prev {
            if targety > rh_max {
                targety = (targety + yincr);
                targety = rh_max - yincr;
            }
        }
        if targetx > room_width*3/4 {
            targetx = xoffset + xincr
        }
        if targetx < room_width/4 {
            targetx = xoffset + 2*xincr
        }
    }
    
}

wrath_set_target()


spd = 3;

