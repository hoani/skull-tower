if hp_blink(hp) {
    return
}

if state.current = state_telegraph_hands {
    draw_sprite_ext(spr_gluttony_telegraph, state.step/4, x, y, 1, 8, 0, c_white, 1);
}

draw_self()

var hands_y = y + 2*sin(2*pi*global.step/60);
if state.current == state_telegraph_hands {
    hands_y = y - state.step/8;
}

if state.current == state_drop_hands {
    var bottom = room_height - 8;
    var delta = bottom - y;
    
    hands_y = min(bottom - delta * (state.step - 60)/60, bottom);
}

draw_sprite(spr_greed_hands, hands_image, x, hands_y);
