
var _frac = 1 - count/lifetime;
shader_set(shd_dissolve);
var _uniform_frac = shader_get_uniform(shd_dissolve, "frac");
shader_set_uniform_f(_uniform_frac, _frac);


draw_self()
shader_reset();
