active = false

image_index = 0
image_speed = 0

state_wait = 0
state_cycle_up = 1
state_cycle_right = 2
state_cycle_left = 3
state_cycle_down = 4
state_taunt =  5

state = new_state(state_wait)

boss_index = BI_LUST
boss_obj = obj_lust

if boss_registry_get(boss_index) == BOSS_DEFEAT {
    instance_destroy()
    return;
}

gravity_left = instance_create_sfx(room_width/2, -room_height, obj_gravity_field, {
    image_xscale: 10, image_yscale: 10, image_angle: 180,    
})

gravity_right = instance_create_sfx(room_width/2, -room_height, obj_gravity_field, {
    image_xscale: 10, image_yscale: 10, image_angle: 0,    
})

gravity_up = instance_create_sfx(room_width/2, -room_height, obj_gravity_field, {
    image_xscale: 10, image_yscale: 10, image_angle: 90,    
})

gravity_down = instance_create_sfx(room_width/2, -room_height, obj_gravity_field, {
    image_xscale: 10, image_yscale: 10, image_angle: 270,    
})



