

shader_set(shd_dissolve_color);
shader_set_uniform_f(shader_get_uniform(shd_dissolve_color, "frac"), power(step/SHADOW_FRAMES, 2));
shader_set_uniform_f(shader_get_uniform(shd_dissolve_color, "color"), r, g, b);
draw_self()

shader_reset();
