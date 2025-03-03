
function draw_ending_text(_x, _y, _text, _frac) {
    draw_set_color(C_WHITE);
    draw_set_font(fnt_story)
    draw_set_halign(fa_left)
    draw_set_valign(fa_top)
    
    shader_set(shd_dissolve);
    shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), _frac);
    
    draw_text(_x, _y, _text);
    shader_reset();
}

var _sx = 24;
var _sy = 28;

draw_set_color(C_WHITE);
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_font(fnt_timer)
draw_text(8, 8, "Time");
draw_set_font(fnt_story)
draw_text(8, 16, time);

draw_set_halign(fa_right)
draw_set_valign(fa_top)
draw_set_font(fnt_timer)
draw_text(room_width - 8, 8, "Deaths");
draw_set_font(fnt_story)
draw_text(room_width - 8, 16, $"{stats_deaths()}");



var _frac = clamp((state.step-(story_duration-16))/16, 0, 1)
switch state.current {
    case state_story0:
        draw_ending_text(_sx, _sy, string_copy(story_text[0], 0, story_index), _frac)
        break;
    case state_story1:
        draw_ending_text(_sx, _sy, string_copy(story_text[1], 0, story_index), _frac)
        break;
    case state_story2:
        draw_ending_text(_sx, _sy, string_copy(story_text[2], 0, story_index), 0)
        _frac = clamp(1-(state.step-64)/16, 0, 1);
    
        shader_set(shd_dissolve);
        shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), _frac);
        
        draw_sprite(spr_ending_award, award, room_width/2, 60)
        shader_reset();
        break;
    case state_credits:
        draw_ending_text(_sx, _sy, story_text[2], 0)
        draw_sprite(spr_ending_award, award, room_width/2, 60)
        _frac = clamp(1-(state.step-64)/16, 0, 1);
        
        shader_set(shd_dissolve);
        shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), _frac);
        
        draw_sprite(spr_credits, 0, room_width/2, room_height)
        shader_reset();
        break;
}
