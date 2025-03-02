if !active {
    return		
}

if boss_registry_get(boss_index) == BOSS_FIGHT {
    state_set(state, state_go_up)
}

state_update(state)

switch state.current {
    case state_wait:
        if state.step >= 30 {
            state_set(state, state_teleport)
            targety = y + 56
        }
        break;
    case state_teleport:
        if state.step >= 16 {
            state_set(state, state_taunt)
            y = targety
        }
        break;
    case state_taunt:
        image_index = 0;
        if state.step == 30 {
            spawn_title_envy()
        }
        if global.step % 30 == 0 && state.step >= 60 && !instance_exists(obj_boss_title) {
            state_set(state, state_go_up)
            targety = ystart
        }
        break
    case state_go_up:
        image_index = 0;
        if state.step >= 16 {
            y = targety
            instance_create_enemy(x, y, boss_obj)
            instance_destroy()
        }
        break
}
