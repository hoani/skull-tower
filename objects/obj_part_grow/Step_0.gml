if lateral_update() {
    x += dx
    y += dy
}

count-=global.s

if count <= 0 {
    instance_destroy()
    if fade_on_destroy {
        instance_create_depth(x, y, depth, obj_part_fade, {
            scale: scale,
            image_angle: image_angle,
            xspd: xspd,
            yspd: yspd,
            sprite_index: sprite_index,
            image_blend: image_blend,
        })
    }
}

image_xscale = scale * (1 - count/lifetime)
image_yscale = scale * (1 - count/lifetime)