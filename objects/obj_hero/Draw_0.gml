
hero_draw(x, y);

if dash.distance > 0 {
    
    var vec = {x: (dash.x - x)/dash.distance, y: (dash.y - y)/dash.distance};
    var dist = dash.distance;
    var dist = dash.distance;
    
    //while (dist > 8) {
        //shader_set(shd_dissolve_color);
        //shader_set_uniform_f(shader_get_uniform(shd_dissolve_color, "frac"), 1.0-power(dist/dash.distance, 2));
        //shader_set_uniform_f(shader_get_uniform(shd_dissolve_color, "color"), 255/256.0, 214/256.0, 215/256.0);
        //hero_draw(x + vec.x*dist, y + vec.y*dist);
        //
        //shader_reset();
        //
        //dist -= 2 + dash.distance/16;
    //}
    
    while (dist > 4) {
        var _tex = sprite_get_texture(spr_hero, 0);
        var _tw = texture_get_texel_width(_tex);
        var _th = texture_get_texel_height(_tex);
        shader_set(shd_dash_projection);
        shader_set_uniform_f(shader_get_uniform(shd_dash_projection, "texel"), _tw, _th);
        shader_set_uniform_f(shader_get_uniform(shd_dash_projection, "color"), 229/256.0, 45/256.0, 64/256.0);
        hero_draw(x + vec.x*dist, y + vec.y*dist);
        
        shader_reset();
        
        dist -= 4 + dash.distance/8;
    }
}






if !global.debug {
    return
}


draw_set_color(c_white);
draw_set_halign(fa_center)
draw_text(x, y +12, state.current)

if f.floor.inst != noone {
    draw_set_color(c_fuchsia)
    draw_set_alpha(0.5)
    draw_rectangle(f.floor.inst.x, f.floor.inst.y, f.floor.inst.x+15, f.floor.inst.y+15, false);
}

if f.wall.left != noone {
    draw_set_color(c_blue)
    draw_set_alpha(0.5)
    draw_rectangle(f.wall.left.x, f.wall.left.y, f.wall.left.x+12, f.wall.left.y+12, false);
}

if f.wall.right != noone {
    draw_set_color(c_teal)
    draw_set_alpha(0.5)
    draw_rectangle(f.wall.right.x, f.wall.right.y, f.wall.right.x+12, f.wall.right.y+12, false);
}

if f.roof != noone {
    draw_set_color(c_green)
    draw_set_alpha(0.5)
    draw_rectangle(f.roof.x, f.roof.y, f.roof.x+8, f.roof.y+8, false);
}

draw_set_color(c_white)
draw_set_alpha(1)
