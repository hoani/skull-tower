
var img = has_controller(global.cmds)

if triggered && !done {
    var _frac = max(0, 1 - count/16);
    shader_set(shd_dissolve);
    var _uniform_frac = shader_get_uniform(shd_dissolve, "frac");
    shader_set_uniform_f(_uniform_frac, _frac);
    
    
    draw_sprite(which, img, room_width/2, room_height/2)
    shader_reset();
} else if done && count < 16 {
    var _frac = min(1, count/16);
    shader_set(shd_dissolve);
    var _uniform_frac = shader_get_uniform(shd_dissolve, "frac");
    shader_set_uniform_f(_uniform_frac, _frac);
    
    
    draw_sprite(which, img, room_width/2, room_height/2)
    shader_reset();
}
