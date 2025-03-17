


if dash.distance > 0 {
    hero_draw_projection()
}

hero_draw(x, y);






if !global.debug || global.do_recording {
    return
}


draw_set_color(c_white);
draw_set_halign(fa_center)
draw_text(x, y +12, state.current)

if instance_exists(f.floor.inst) {
    draw_set_color(c_fuchsia)
    draw_set_alpha(0.5)
    draw_rectangle(f.floor.inst.x, f.floor.inst.y, f.floor.inst.x+15, f.floor.inst.y+15, false);
}

if instance_exists(f.wall.left) {
    draw_set_color(c_blue)
    draw_set_alpha(0.5)
    draw_rectangle(f.wall.left.x, f.wall.left.y, f.wall.left.x+12, f.wall.left.y+12, false);
}

if instance_exists(f.wall.right) {
    draw_set_color(c_teal)
    draw_set_alpha(0.5)
    draw_rectangle(f.wall.right.x, f.wall.right.y, f.wall.right.x+12, f.wall.right.y+12, false);
}

if instance_exists(f.roof) {
    draw_set_color(c_green)
    draw_set_alpha(0.5)
    draw_rectangle(f.roof.x, f.roof.y, f.roof.x+8, f.roof.y+8, false);
}

draw_set_color(c_white)
draw_set_alpha(1)
//
//var c = body_collision_coords(-w_2, -h_2, w_2, h_2)
//
//draw_set_color(c_white)
//draw_set_alpha(0.5)
//draw_rectangle(c.x0, c.y0, c.x1, c.y1, false);
