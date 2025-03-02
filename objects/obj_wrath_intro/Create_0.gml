active = false

image_index = 0
image_speed = 0

state_appear = 0
state_taunt =  1

state = new_state(state_appear)

boss_index = BI_WRATH
boss_obj = obj_wrath

if boss_registry_get(boss_index) == BOSS_DEFEAT {
    instance_destroy()
    return;
}


