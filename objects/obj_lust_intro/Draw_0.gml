
if state.current < state_cycle_down{
    if state.step > 20 {
        draw_sprite_ext(spr_lust_hair, 0, x, y, 1, 1, state.step*15, c_white, 1);
    } else {
        var img = animate(1, 6, 16, state.step);
        var dir = (state.current == state_cycle_up) ? 90 : ((state.current == state_cycle_left) ? 0 : ((state.current == state_cycle_right) ? 180 : 270));    
        draw_sprite_ext(spr_lust_hair, img, x, y, 1, 1, dir, c_white, 1);
    }
} else {
    var img = animate(1, 6, 16, state.step);
    draw_sprite_ext(spr_lust_hair, img, x, y, 1, 1, 270, c_white, 1);
}

draw_self()

