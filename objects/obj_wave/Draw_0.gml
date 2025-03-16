
shader_set(shd_dissolve);
shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), 0.125);

draw_sprite_ext(wave, 1, x, y, image_xscale, image_yscale, image_angle, c_trail, 1.0);

shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), 0.25);
shader_set_uniform_f(shader_get_uniform(shd_dissolve, "time"), round(global.mono/4) % 64);

draw_sprite_ext(wave, 0, x, y, image_xscale, image_yscale, image_angle, c_trail, 1.0);


shader_reset();

draw_self()
