if !active {
    return		
}

if boss_registry_get(BI_GLUTTONY) == BOSS_FIGHT {
    state_set(state, GLUTTONY_INTRO_GO_UP)
    y = ystart - 48
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
            state_set(state, GLUTTONY_INTRO_GO_UP)
        }
        break
    case GLUTTONY_INTRO_GO_UP:
        image_index = 1;
        y -= 1;
        if y <= ystart - 48 {
            instance_create_enemy(x, ystart-48, obj_gluttony)
            instance_destroy()
        }
        break
}
