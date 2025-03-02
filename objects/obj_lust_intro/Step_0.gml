if !active {
    return		
}

if boss_registry_get(boss_index) == BOSS_FIGHT {
    gravity_down.y = room_height/2
    instance_create_enemy(x, y, boss_obj, {
        gravity_up: gravity_up,
        gravity_down: gravity_down,    
        gravity_left: gravity_left,    
        gravity_right: gravity_right,        
    })
    instance_destroy()
}

state_update(state)

switch state.current {
    case state_wait:
        if state.step >= 30 {
            state_set(state, state_cycle_up)
            gravity_up.y = room_height/2
        }
        break;
    case state_cycle_up:
        obj_hero.disable = false
        if state.step >= 30 {
            state_set(state, state_cycle_right)
            gravity_up.y = -room_height
            gravity_right.y = room_height/2
        }
        break;
    case state_cycle_right:
        if state.step >= 30 {
            state_set(state, state_cycle_left)
            gravity_right.y = -room_height 
            gravity_left.y = room_height/2
        }
        break;
    case state_cycle_left:
        if state.step >= 30 {
            state_set(state, state_cycle_down)
            gravity_left.y = -room_height 
            gravity_down.y = room_height/2
        }
        break;
    case state_cycle_down:
        if state.step >= 30 {
            state_set(state, state_taunt)
        }
        break;
    case state_taunt:
        if state.step == 30 {
            spawn_title_lust()
            obj_hero.disable = true
        }
        if state.step>60 && !instance_exists(obj_boss_title) {
            instance_create_enemy(x, y, boss_obj, {
                gravity_up: gravity_up,
                gravity_down: gravity_down,    
                gravity_left: gravity_left,    
                gravity_right: gravity_right,        
            })
            instance_destroy()
        }
        break
}
