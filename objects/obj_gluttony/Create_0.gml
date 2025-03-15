#macro GLUT_SCAN 0
#macro GLUT_TELEGRAPH 1
#macro GLUT_ATTACK 2
#macro GLUT_RECOVER 3

state = new_state(GLUT_SCAN);

telegraph_frames = 90;
xspd = 1.5;
recoverspd = 0.75;

enraged = false
hp = new_hp(4, 120, function(){
    create_sfx(snd_boss_damage, x, y)
    if hp.current <= 2 {
        enraged = true; 
        sprite_index = spr_gluttony_enraged; 
        telegraph_frames = 75;
        xspd = 2
        recoverspd = 1
    }
})

obj_control.boss_hp = hp

image_index = 1

targetx = room_width/8

function gluttony_set_target() {
    var prev = targetx;
    if !enraged {
        if instance_exists(obj_hero) {
            targetx = floor(4*obj_hero.x/room_width)*(room_width/4) + room_width/8;
        }
        if targetx == prev {
            targetx = (targetx + room_width/4) % (room_width*3/4)
        }
    } else {
        if instance_exists(obj_hero) {
            targetx = floor(3*obj_hero.x/room_width)*(room_width/4) + room_width/4;
        }
        if targetx == prev {
            if targetx >= room_width*3/4 {
                targetx = room_width/4
            } else {
                targetx = (targetx + room_width/4)
            }
        }
    }
}

gluttony_set_target()




