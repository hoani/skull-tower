
shader_set(shd_dissolve);
shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), 1-fade);
shader_set_uniform_f(shader_get_uniform(shd_dissolve, "time"), 0);





draw_self()

shader_reset();
