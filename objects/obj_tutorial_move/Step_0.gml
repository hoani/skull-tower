if instance_exists(obj_hero) {
    if obj_hero.x > room_width/2 {
        active = false
    }
}

if active {
    fade = clamp(fade + 1/8, 0, 1)
} else {
    fade = clamp(fade - 1/8, 0, 1)
    if fade == 0 {
        instance_destroy()
    }
}

image_index = has_controller(global.cmds)