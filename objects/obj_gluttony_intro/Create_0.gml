active = false

image_index = 0
image_speed = 0

#macro GLUTTONY_INTRO_APPEAR 0
#macro GLUTTONY_INTRO_TAUNT 1

state = new_state(GLUTTONY_INTRO_APPEAR)

if boss_registry_get(BI_GLUTTONY) == BOSS_DEFEAT {
    instance_destroy()
    return;
}
