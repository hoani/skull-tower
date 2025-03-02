hp_update(hp)

if hp.current <= 0 {
    instance_destroy()
    instance_create_enemy(x, y, obj_boss_die, {sprite_index: spr_envy_die})
}


state_update(state)

switch state.current {
    case state_scan:
        image_index = 0
        if state.step >= 120 && global.step {
            state_set(state, state_teleport);
            envy_set_position()
        }
        break;
    case state_teleport:
        if state.step >= 16 {
            state_set(state, state_telegraph)
            x = targetx
            y = targety
        }
        break;
    case state_telegraph:
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
        image_index = 1;
        if !instance_exists(obj_envy_spike) && !instance_exists(obj_envy_spike_spawn) {
            state_set(state, state_cooldown);
        }
        break
    case state_cooldown:
        image_index = 2;
        if state.step >= 30 {
            state_set(state, state_scan);
        }
        break
}



