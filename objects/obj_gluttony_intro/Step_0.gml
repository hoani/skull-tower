if !active {
    return		
}

if boss_registry_get(BI_SLOTH) == BOSS_FIGHT {
    instance_create_enemy(x, y, obj_sloth)
    instance_destroy()
}

state_update(state)

switch state.current {
    case GLUTTONY_INTRO_APPEAR:
        image_index = 0
        x -= 2;
        y = ystart + 4*sin(2*pi*(x-room_width/2)/60);
        if x <= room_width/2 {
            state_set(state, GLUTTONY_INTRO_TAUNT)
        }
        break;
    case GLUTTONY_INTRO_TAUNT:
        image_index = 1
        if state.step == 30 {
            spawn_title_gluttony()
        }
        if state.step>60 && !instance_exists(obj_boss_title) {
            instance_create_enemy(x, y, obj_gluttony)
            instance_destroy()
        }
        break
}
