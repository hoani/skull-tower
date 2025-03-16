hp_update(hp)

if hp.current <= 0 {
    instance_destroy()
    instance_create_enemy(x, y, obj_boss_die, {sprite_index: spr_greed_die})
}


state_update(state)

switch state.current {
    case state_scan:
        image_index = 0
        hands_image = 0
        x = xstart + 64*sin(2*pi*state.step/120);
        y = ystart + 32*sin(2*pi*state.step/60);
        if state.step >= 120 {
            state_set(state, state_telegraph);
        }
        break;
    case state_telegraph:
        image_index = 1
        hands_image = 1
        if state.step >= spawn_count * 30 {
            greed_spawn_block()
        }
        if spawn_count >= 4 {
            state_set(state, state_spawn);
            spawn_dir = -spawn_dir // for next round.
            spawn_count = 0;
            spawn_x = -(24+irandom(1)*8);
            spawn_pattern_index = (spawn_pattern_index + 1) % array_length(spawn_patterns)
        }
        break;
    case state_spawn:
        image_index = 2
        hands_image = 1
        if state.step >= 40 {
            if enraged {
                state_set(state, state_scan_big_block)
            } else {
                state_set(state, state_scan_hands);
            }
        }
        break
    case state_scan_big_block:
        image_index = 0
        hands_image = 0
        x = xstart + 64*sin(2*pi*state.step/120);
        y = ystart + 32*sin(2*pi*state.step/60);
        if state.step >= 120 {
            state_set(state, state_telegraph_big_block);
        }
        break;
    case state_telegraph_big_block:
        image_index = 1
        hands_image = 1
        if state.step >= spawn_count * 30 {
            greed_spawn_big_block()
            state_set(state, state_spawn_big_block);
        }
        break;
    case state_spawn_big_block:
        image_index = 2
        hands_image = 1
        if state.step >= 40 {
            state_set(state, state_scan_hands);
        }
        break
    case state_scan_hands:
        image_index = 1
        hands_image = 0
        x = xstart + 64*sin(2*pi*state.step/120);
        y = ystart + 32*sin(2*pi*state.step/60);
        if state.step >= 120 && abs(obj_hero.x - x) < 16 {
            state_set(state, state_telegraph_hands);
        }
        break
    case state_telegraph_hands:
        image_index = 2
        hands_image = 2
        if state.step >= 50 {
            state_set(state, state_drop_hands);
            greed_trade_blocks()
            instance_create(x, room_height - 8, obj_gluttony_slash, {
                depth: depth-1,
                image_xscale: enraged ? 1.5 : 1,
            })
            screen_shake_y(4, 6, 1)
            create_sfx(snd_crash, x, y)
        }
        break;
    case state_drop_hands:
        image_index = 3
        hands_image = 3
    
        if state.step >= 120 {
            state_set(state, state_return_to_scan);
        }
       
        break
    case state_return_to_scan:
        image_index = 3
        hands_image = 3
    
        var dx = xstart - x;
        var dy = ystart - y;
        if abs(dx) < return_spd {
            x = xstart
        } else {
            x += sign(dx) * return_spd;
        }
        if abs(dy) < return_spd {
            y = ystart
        } else {
            y += sign(dy) * return_spd;
        }
    
        if x == xstart && y == ystart {
            state_set(state, state_scan)
        }
    
        break
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

