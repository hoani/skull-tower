active = false

image_index = 0
image_speed = 0

state_wait = 0
state_look = 1
state_move = 2
state_taunt =  3

state = new_state(state_wait)

boss_index = BI_PRIDE
boss_obj = obj_pride

if boss_registry_get(boss_index) == BOSS_DEFEAT {
    instance_destroy()
    return;
}


