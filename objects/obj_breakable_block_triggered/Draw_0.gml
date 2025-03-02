var dx = 0
if triggered && countdown > 0 {
    dx += 1*sin(2*pi*countdown/15)
}

draw_sprite_ext(sprite_index, image_index, x+dx, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
