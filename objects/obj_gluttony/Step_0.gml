hp_update(hp)

if hp.current <= 0 {
    instance_destroy()
    instance_create_depth(x, y, 0, obj_boss_die, {sprite_index: spr_gluttony_die})
}

if enraged {
    if state.step % 8 == 0 {
        var xpos = x - 12 + irandom(24);
        var ypos = y - 16 - irandom(16)
        instance_create_enemy(xpos, ypos, obj_part_fade, {
            depth: depth - 1,
            yspd: -0.5,
        })
    }
}




state_update(state)

switch state.current {
    case GLUT_SCAN:
        image_index = 1;
        var dx = targetx - x;
        if abs(dx) < xspd {
            x = targetx
            state_set(state, GLUT_TELEGRAPH);
        } else {
            x += sign(dx) * xspd;
        }
        y = ystart + 4*sin(2*pi*(x-room_width/2)/60);
        break;
    case GLUT_TELEGRAPH:
        image_index = 2;
        if state.step >= telegraph_frames {
            state_set(state, GLUT_ATTACK);
            y = room_height - 16;
            instance_create(x, room_height - 8, obj_gluttony_slash, {
                depth: depth-1,
                image_xscale: enraged ? 2.25 : 1,
            })
            screen_shake_y(4, 6, 1)
            create_sfx(snd_crash, x, y)
        }
        break
    case GLUT_ATTACK:
        image_index = 3;
        if state.step >= 30 {
            state_set(state, GLUT_RECOVER);
        }
        break
    case GLUT_RECOVER:
        image_index = 0;
        var dy = ystart - y;
        if abs(dy) < recoverspd {
            y = ystart
            state_set(state, GLUT_SCAN);
            gluttony_set_target()
        } else {
            y += sign(dy) * recoverspd;
        }
        break
}



