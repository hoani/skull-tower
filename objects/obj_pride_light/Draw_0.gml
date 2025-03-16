var _frac = 0;
if instance_exists(block) {
    _frac = clamp(1.25 - point_distance(x, y, block.x, block.y)/128, 0, 1);
}


shader_set(shd_dissolve);
shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), _frac);
shader_set_uniform_f(shader_get_uniform(shd_dissolve, "time"), 0);


draw_self()
shader_reset();