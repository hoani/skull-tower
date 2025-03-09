
function draw_title_text(_x, _y, _text, _frac) {
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


var _frac = clamp(state.step/fade_frames, 0, 1);

switch state.current {
    case state_title:
        draw_sprite(spr_title, 0, room_width/2, 40)
        draw_sprite(spr_credits, 0, room_width/2, room_height)
        break;
    case state_fade:
        shader_set(shd_dissolve);
        shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), _frac);
        draw_sprite(spr_title, 0, room_width/2, 40)
        draw_sprite(spr_credits, 0, room_width/2, room_height)
        shader_reset();
        break;
    case state_story0:
    case state_story1:
    case state_story2:
        draw_title_text(_sx, _sy, string_copy(story_text[story_index], 0, text_index), 0)
        break;
    case state_story0_fade:
    case state_story1_fade:
    case state_story2_fade:
        draw_title_text(_sx, _sy, story_text[story_index], _frac)
        break;
}
