active = false

image_index = 0
image_speed = 0

#macro SLOTH_INTRO_APPEAR 0
#macro SLOTH_INTRO_TAUNT 1

state = new_state(SLOTH_INTRO_APPEAR)

if boss_registry_get(BI_SLOTH) == BOSS_DEFEAT {
    instance_destroy()
    return;
}



for (var i = 0; i < 4; i++) {
    instance_create_enemy(x, y, obj_sloth_inner, { image_angle: i*90 })
    instance_create_enemy(x, y, obj_sloth_outer, { image_angle: i*90 })
}