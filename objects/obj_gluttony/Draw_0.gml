

if state.current = GLUT_TELEGRAPH {
    var telegraph_xscale = enraged ? 2.25: 1;
    draw_sprite_ext(spr_gluttony_telegraph, state.step/4, x, y, telegraph_xscale, 8, 0, c_white, 1);

}

if !hp_blink(hp) {
    draw_self()
}


