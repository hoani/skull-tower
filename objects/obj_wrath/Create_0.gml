state_scan = 0
state_telegraph = 1
state_attack = 2
state_recover = 3;


state = new_state(state_scan);

hp = new_hp(6, 70, function(){
    create_sfx(snd_boss_damage, x, y)
})

obj_control.boss_hp = hp

image_index = 1

rw = room_width - 16
xoffset = 8 + rw/8
xincr = rw/4

rh = room_height - 16
yoffset = 8 + rh/8
yincr = rh/4


targetx = xoffset
targety = yoffset


do_target_x = false

function wrath_set_target() {
    do_target_x = !do_target_x; // toggle
    if do_target_x {
        var prev = targetx;
        if instance_exists(obj_hero) {
            targetx = floor(4*obj_hero.x/room_width)*(xincr) + xoffset;
        }
        if targetx == prev {
            targetx = (targetx + xincr) % room_width
        }
        if targety > room_height*3/4 {
            targety = yoffset + yincr
        }
        if targety < room_height/4 {
            targety = yoffset + 2*yincr
        }
    } else {
        var prev = targety;
        if instance_exists(obj_hero) {
            targety = floor(4*(obj_hero.y-16)/room_height)*(yincr) + yoffset;
        }
        if targety == prev {
            targety = (targety + yincr) % room_height
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

