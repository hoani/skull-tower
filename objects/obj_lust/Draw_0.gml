if hp_blink(hp) {
    return
}

if state.current == state_idle {
    draw_sprite_ext(spr_lust_hair, 0, x, y, 1, 1, state.step*15, c_white, 1);
} else {
    var img = animate(1, 6, 16, state.step);
    draw_sprite_ext(spr_lust_hair, img, x, y, 1, 1, angle, c_white, 1);
}



draw_self()


