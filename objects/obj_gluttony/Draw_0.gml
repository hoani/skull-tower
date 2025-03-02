

if state.current = GLUT_TELEGRAPH {
    draw_sprite_ext(spr_gluttony_telegraph, state.step/4, x, y, 1, 8, 0, c_white, 1);

}

if !hp_blink(hp) {
    draw_self()
}


