hp_update(hp)

if hp.current <= 0 {
    instance_destroy()
    instance_create_depth(x, y, 0, obj_boss_die, {sprite_index: spr_wrath_die})
}


state_update(state)

switch state.current {
    case state_scan:
        image_index = animate(1, 2, 15, state.step);
        var dx = targetx - x;
        var dy = targety - y;
        if abs(dx) < spd && abs(dy) < spd {
            x = targetx            
            y = targety
            state_set(state, state_telegraph);
        } else {
            x = abs(dx) < spd ? targetx : x + sign(dx) * spd;
            y = abs(dy) < spd ? targety : y + sign(dy) * spd;
        }
        break;
    case state_telegraph:
        image_index = do_target_x ? 3 : 5;
        if state.step >= 70 || (enraged && !do_target_x && state.step >= 5) {
            state_set(state, state_attack);
            var obj = do_target_x ? obj_wrath_slash_verical: obj_wrath_slash_horizontal;
            var _x = do_target_x ? x : room_width/2;
            var _y = do_target_x ? room_height/2 : y;
            instance_create(_x, _y, obj, {
                depth: depth-1,
            })
            if do_target_x {
                screen_shake_y(4, 6, 1)
            } else {
                screen_shake_x(4, 6, 1)
            }
            
            create_sfx(snd_wrath_slash, x, y)
        }
        break
    case state_attack:
        image_index = do_target_x ? 4 : 6;
        if state.step >= 30 || (do_target_x && enraged && state.step >= 5) {
            if do_target_x && enraged {
                state_set(state, state_telegraph)
                do_target_x = !do_target_x
            } else {
                state_set(state, state_recover);
            }
        }
        break
    case state_recover:
        image_index = animate(1, 2, 20, state.step);
        if state.step >= 40 {
            state_set(state, state_scan);
            wrath_set_target()
        }
        break
    case state_transform:
        image_index = animate(0, 6, 8, state.step);
        if state.step == 10 {
            create_sfx(snd_enrage, x, y)
            
        }
        if state.step >= 48 {
            enraged = true
            sprite_index=spr_wrath_enraged
            state_set(state, state_scan);
            wrath_set_target()
            do_target_x = true;
        }
}



if enraged {
    if state.step % 8 == 0 {
        var xpos = x - 16 + irandom(32);
        var ypos = y - irandom(16)
        instance_create_enemy(xpos, ypos, obj_part_fade, {
            depth: depth + 1,
            yspd: -0.5,
            image_angle: random(360),
            scale: 0.75,
        })
    }
}
