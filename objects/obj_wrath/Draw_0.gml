

if state.current = state_telegraph {
    if do_target_x || enraged {
        draw_sprite_ext(spr_gluttony_telegraph, state.step/4, x, 0, 1, 10, 0, c_white, 1);
    } 
    if !do_target_x || enraged {
        draw_sprite_ext(spr_gluttony_telegraph, state.step/4, 0, y, 1, 10, 90, c_white, 1);
    }
}


if !hp_blink(hp) {
    draw_self()
}


