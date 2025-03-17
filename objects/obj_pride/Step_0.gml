hp_update(hp)

if hp.current <= 0 {
    instance_destroy()
    instance_create_depth(x, y, 0, obj_boss_die, {sprite_index: spr_pride_die})
}


state_update(state)

switch state.current {
    case state_scan:
    case state_retreat:
        image_index = animate(2, 4, 10, state.step);
        var dx = targetx - x;
        var dy = targety - y;
        if abs(dx) < spd && abs(dy) < spd {
            x = targetx            
            y = targety
            state_set(state, state.current+1);
        } else {
            x = abs(dx) < spd ? targetx : x + sign(dx) * spd;
            y = abs(dy) < spd ? targety : y + sign(dy) * spd;
        }
        break;
    case state_telegraph:
        image_index = 6;
        if state.step >= 70 {
            state_set(state, state_attack);
            
            if down {
                instance_create(x, y, obj_pride_slash, { depth: depth-1, image_angle: 0})    
            }
            if left {
                instance_create(x, y, obj_pride_slash, { depth: depth-1, image_angle: 270})    
            }
            if right {
                instance_create(x, y, obj_pride_slash, { depth: depth-1, image_angle: 90})    
            }
            
            create_sfx(snd_wrath_slash, x, y)
        }
        break
    case state_attack:
        if image_index < 12 {
            image_index = animate(7, 6, 2, state.step);
        }
        if state.step >= 40 {
            state_set(state, state_recover);
        }
        break
    case state_recover:
        image_index = animate(2, 4, 10, state.step);
        if state.step >= 20 {
            state_set(state, state_scan);
            pride_set_target()
        }
        break
    case state_far_block:
        image_index = animate(13, 4, 30, global.step);
        if state.step > 60 {
            pride_spawn_block();
            state_set(state, state_far_wait);
        }
        break;
    case state_far_wait:
        image_index = animate(13, 4, 30, global.step);
        if state.step > 60 {
            state_set(state, state_far_wave);
        }
        break;
    case state_far_wave:
        image_index = animate(13, 4, 30, global.step);
        if state.step > 60 {
            state_set(state, state_far_block);
            pride_spawn_wave()
            spawn_cycle++
        }
        break;
    case state_advance:
        // This is scan, but allows for a set numbe of steps to have expired.
        image_index = animate(2, 4, 10, state.step);
        var dx = targetx - x;
        var dy = targety - y;
        if abs(dx) < spd && abs(dy) < spd {
            x = targetx            
            y = targety
            if state.step > 90 {
                state_set(state, state_telegraph);
            }
        } else {
            x = abs(dx) < spd ? targetx : x + sign(dx) * spd;
            y = abs(dy) < spd ? targety : y + sign(dy) * spd;
        }
        break;
}



