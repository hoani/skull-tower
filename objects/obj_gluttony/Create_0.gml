#macro GLUT_SCAN 0
#macro GLUT_TELEGRAPH 1
#macro GLUT_ATTACK 2
#macro GLUT_RECOVER 3

state = new_state(GLUT_SCAN);

hp = new_hp(3, 120, function(){
    create_sfx(snd_boss_damage, x, y)
})

obj_control.boss_hp = hp

image_index = 1

targetx = room_width/8

function gluttony_set_target() {
    var prev = targetx;
    if instance_exists(obj_hero) {
        targetx = floor(4*obj_hero.x/room_width)*(room_width/4) + room_width/8;
    }
    if targetx == prev {
        targetx = (targetx + room_width/4) % (room_width*3/4)
    }
}

gluttony_set_target()


xspd = 2;
recoverspd = 1;
