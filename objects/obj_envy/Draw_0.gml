if hp_blink(hp) {
    return
}

var yoffset = 4*sin(2*pi*global.step/60);

if targety != y || targetx != x {
    var _frac = state.step/16;
    shader_set(shd_dissolve);
    var _uniform_frac = shader_get_uniform(shd_dissolve, "frac");
    shader_set_uniform_f(_uniform_frac, _frac);
    
    
    draw_sprite(sprite_index, image_index, x, y + yoffset);
    
    shader_set_uniform_f(_uniform_frac, 1.0 - _frac);
    
    draw_sprite(sprite_index, image_index, targetx, targety+ yoffset);
    shader_reset();
} else {
    draw_sprite(sprite_index, image_index, x, y + yoffset);
}
