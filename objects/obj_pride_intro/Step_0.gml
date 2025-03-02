if !active {
    return		
}

if boss_registry_get(boss_index) == BOSS_FIGHT {
    instance_create_enemy(x, y, boss_obj)
    instance_destroy()
}

state_update(state)

switch state.current {
    case state_wait:
        image_index = 0
        if state.step >= 30 {
            state_set(state, state_look)
        }
        break;
    case state_look:
        image_index = 0
        if state.step >= 30 {
            state_set(state, state_move)
        }
        break;
    case state_move:
        image_index = 0
        y -= global.s;
        if y <= room_height/2 + 32 {
            state_set(state, state_taunt)
        }
        break;
    case state_taunt:
        image_index = 1
        if state.step == 30 {
            spawn_title_pride()
        }
        if state.step>60 && !instance_exists(obj_boss_title) {
            instance_create_enemy(x, y, boss_obj)
            instance_destroy()
        }
        break
}
