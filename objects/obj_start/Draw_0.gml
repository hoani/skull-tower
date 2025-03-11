
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

#macro START_MENU_ITEM_X 48
#macro START_MENU_ITEM_Y 84

function draw_start_menu_item(yoff, text, selected=false, blink_active=false, c_base=C_BLACK) {
    
    if selected && blink_active {
        if state.step % selected_blink_frames < selected_blinked_frames {
            return // Don't show, blinking.
        }
    }
    
    if selected {
        draw_set_color(C_WHITE)
    } else {
        draw_set_color(c_base)
    }
    
    draw_set_font(fnt_story)
    draw_set_halign(fa_left)
    draw_set_valign(fa_middle)
    if selected {
        text = "  " + text
        draw_sprite(spr_menu_arrow, 0, START_MENU_ITEM_X-4, START_MENU_ITEM_Y + yoff)
    }
    draw_text(START_MENU_ITEM_X, START_MENU_ITEM_Y + yoff, text)    
    
    draw_set_color(C_WHITE)
}

function draw_menu_items(blink_active=false) {
    var c_continue = continue_enabled ? C_BLACK : C_LTGRAY;
    draw_start_menu_item(0, "continue", menu_index == 0, blink_active, c_continue)
    draw_start_menu_item(12, "new game", menu_index == 1, blink_active)
    draw_start_menu_item(24, "credits", menu_index == 2, blink_active)
}

var _sx = 24;
var _sy = 28;


var _frac = clamp(state.step/fade_frames, 0, 1);




switch state.current {
    case state_title:
        draw_sprite(spr_title, 0, room_width/2, 40)
        draw_menu_items()
        break;
    case state_new_selected:
    case state_continue_selected: 
    case state_credits_selected:
        draw_sprite(spr_title, 0, room_width/2, 40)
        draw_menu_items(true)
        break;
    
    case state_new:
        shader_set(shd_dissolve);
        shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), _frac);
        draw_sprite(spr_title, 0, room_width/2, 40)
        draw_menu_items()
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
    case state_credits:
        draw_sprite(spr_title, 0, room_width/2, 40)
    
        shader_set(shd_dissolve);
        shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), _frac);
        draw_menu_items()
    
        _frac = clamp(1 - ((state.step-16)/fade_frames), 0, 1);
        shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), _frac);
        
        draw_sprite(spr_credits, 0, room_width/2, room_height-8)
        shader_reset();
        break;
    case state_credits_fade:
        draw_sprite(spr_title, 0, room_width/2, 40)
    
        shader_set(shd_dissolve);
        shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), _frac);
        draw_sprite(spr_credits, 0, room_width/2, room_height-8)
    
        _frac = clamp(1 - ((state.step-16)/fade_frames), 0, 1);
        shader_set_uniform_f(shader_get_uniform(shd_dissolve, "frac"), _frac);
    
        draw_menu_items()
        shader_reset();
        break;
}
