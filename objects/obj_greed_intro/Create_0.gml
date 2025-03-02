active = false

image_index = 0
image_speed = 0

state_wait = 0
state_move = 1
state_taunt = 2
state_go_up = 3

state = new_state(state_wait)

boss_index = BI_GREED
boss_obj = obj_greed

if boss_registry_get(boss_index) == BOSS_DEFEAT {
    instance_destroy()
    return;
}

