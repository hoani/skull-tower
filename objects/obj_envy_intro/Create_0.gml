active = false

image_index = 0
image_speed = 0

state_wait = 0
state_teleport = 1
state_taunt = 2
state_go_up = 3

state = new_state(state_wait)

boss_index = BI_ENVY
boss_obj = obj_envy

if boss_registry_get(boss_index) == BOSS_DEFEAT {
    instance_destroy()
    return;
}

targetx = xstart
targety = ystart
