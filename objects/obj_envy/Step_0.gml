hp_update(hp)

if hp.current <= 0 {
    instance_destroy()
    instance_create_enemy(x, y, obj_boss_die, {sprite_index: spr_envy_die})
}




state_update(state)

switch state.current {
    
    case state_scan:
        image_index = 0
        if state.step >= 160 && global.step {
            state_set(state, state_teleport);
            envy_set_position()
        }
        break;
    case state_teleport:
        if state.step >= 16 {
            state_set(state, state_telegraph)
            create_sfx(snd_teleport, x, y)
            x = targetx
            y = targety
        }
        break;
    case state_telegraph:
        obj_envy_circle.image_index = 1;
        image_index = 1
        if state.step >= spawn_count * 10 {
            envy_spawn_summon()
        }
        if spawn_count >= 6 {
            state_set(state, state_spawn);
            spawn_dir = -spawn_dir // for next round.
            spawn_count = 0;
        }
        break;
    case state_spawn:
        if !instance_exists(obj_envy_spike_spawn) {
            obj_envy_circle.image_index = 0;
        }
        image_index = 1;
        if !instance_exists(obj_envy_spike) && !instance_exists(obj_envy_spike_spawn) {
            state_set(state, state_cooldown);
        }
        break
    case state_cooldown:
        image_index = 2;
        
        if state.step >= 30 {
            state_set(state, state_wave_teleport);
            create_sfx(snd_teleport, x, y)
            targetx = scx
            targety = scy
        }
        break
    case state_wave_teleport:
        image_index = 0;
        
        if state.step >= 16 {
            state_set(state, state_wave);
            x = targetx
            y = targety
        }
        break
    case state_wave:
        image_index = 1;
        obj_envy_circle.image_index = envy_wave_circle_image()
        if state.step >= 55 {
            
            state_set(state, state_scan);
            envy_emit_wave()
            obj_envy_circle.image_index = 0;
        }
        break
    case state_transform_teleport:
        image_index = 0;
        
        if state.step >= 16 {
            state_set(state, state_transform_wait);
            x = targetx
            y = targety
        }
        break
    case state_transform_wait:
        image_index = 2;
        obj_envy_circle.image_index = 0
        if !hp_invulnerable(hp) {
            create_sfx(snd_enrage, x, y)
            state_set(state, state_transform);
            instance_create_depth(x, y, depth +1, obj_part_shrink, {
                sprite_index: spr_envy_summon_circle,
                image_blend: C_DKGREEN,
                lifetime: 32,   
                scale: 3,
            })
        }
        break
    case state_transform:
        image_index = animate(0, 5, 4, state.step)
         
        if state.step >= 20 {
            state_set(state, state_wave);
            sprite_index = spr_envy_enraged
            enraged = true
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



