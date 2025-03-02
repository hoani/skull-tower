if !active {
    return		
}

if boss_registry_get(boss_index) == BOSS_FIGHT {
    state_set(state, state_go_up)
}

state_update(state)

switch state.current {
    case state_wait:
        image_index = 0;
        if state.step >= 30 {
            state_set(state, state_move)
        }
        break;
    case state_move:
        image_index = 1;
        x = xstart + 64*sin(2*pi*state.step/120);
        y = ystart + 32*sin(2*pi*state.step/60);
        if state.step >= 120 {
            state_set(state, state_taunt)
        }
        break;
    case state_taunt:
        image_index = 0;
        if state.step == 30 {
            spawn_title_greed()
        }
        if state.step>60 && !instance_exists(obj_boss_title) {
            state_set(state, state_go_up)
        }
        break
    case state_go_up:
        image_index = 0;
        y -= 1;
        if y <= ystart - 48 {
            instance_create_enemy(xstart, ystart-48, boss_obj)
            instance_destroy()
        }
        break
}
