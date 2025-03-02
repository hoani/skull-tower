

if state.current = state_telegraph {
    if left {
        draw_sprite_ext(spr_pride_telegraph, 0, x-1, y-1, 1, 1, 270, c_white, 1);
    }
    if right {
        draw_sprite_ext(spr_pride_telegraph, 0, x+1, y-1, 1, 1, 90, c_white, 1);
    }
    if down {
        draw_sprite_ext(spr_pride_telegraph, 0, x, y, 1, 1, 0, c_white, 1);
    }
}

if !hp_blink(hp) {
    draw_self()
}


