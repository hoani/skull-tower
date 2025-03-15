hp_update(hp)

if hp.current <= 0 {
    instance_destroy()
    instance_create_depth(x, y, 0, obj_boss_die, {sprite_index: spr_lust_die})
}


state_update(state)

switch state.current {
    case state_idle:
        if state.step >= (40) {
            state_set(state, state_telegraph);
            lust_set_target()
        }
        break;
    case state_telegraph:
        if state.step >= (60 - 4*hp.current) {
            state_set(state, state_switch);
            lust_trigger_target()
        }
        break;
    case state_switch:
        if state.step >= 40 {
            state_set(state, state_spawn);
            lust_spawn_blocks()  
        }
        break
    case state_spawn:
        if !instance_exists(obj_breakable_block) && !instance_exists(obj_breakable_block_summon) {
            state_set(state, state_idle);
        }
        break
}



if enraged {
    if state.step % 16 == 0 {
        var xpos = x - 12 + irandom(24);
        var ypos = y - 8 - irandom(16)
        instance_create_enemy(xpos, ypos, obj_part_grow, {
            sprite_index: spr_lust_heart,
            image_blend: C_RED,
            scale: 0.5,
            lifetime: 32,
            depth: depth - 1,
            yspd: -0.125,
            fade_on_destroy: true,
        })
    }
}
