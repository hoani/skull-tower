if !active {
    return		
}

if boss_registry_get(BI_SLOTH) == BOSS_FIGHT {
    instance_create_enemy(x, y, obj_sloth)
    instance_destroy()
}

state_update(state)

switch state.current {
    case SLOTH_INTRO_APPEAR:
        image_index = animate(0, 2, 60, global.step)
        if state.mono > 60 {
            state_set(state, SLOTH_INTRO_TAUNT)
        }
        break;
    case SLOTH_INTRO_TAUNT:
        image_index = animate(2, 2, 60, global.step)
        if state.step == 30 {
            spawn_title_sloth()
        }
        if state.step>60 && !instance_exists(obj_boss_title) {
            instance_create_enemy(x, y, obj_sloth)
            instance_destroy()
        }
        break
}
