state_scan = 0
state_telegraph = 1
state_attack = 2
state_recover = 3;


state = new_state(state_scan);

hp = new_hp(6, 120, function(){
    create_sfx(snd_boss_damage, x, y)
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
posy = [80, 64, 80]
num_pos = 3;

down = false
left = false
right = false

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
    } else if hp > 2 {
        if attack_pos == 0 {
            down = true
            right = true
        }
        if attack_pos == 1 {
            down = true
            left = true
            right = true
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

