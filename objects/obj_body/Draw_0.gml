var c = body_collision_coords(-w_2, -h_2, w_2, h_2)

draw_set_color(c_white)
draw_set_alpha(0.5)
draw_rectangle(c.x0, c.y0, c.x1, c.y1, false);

draw_set_color(c_green)
draw_rectangle(xprevious-2, yprevious, xprevious+2, yprevious, true)
draw_rectangle(xprevious, yprevious-2, xprevious, yprevious+2, true)

draw_set_color(c_red)
draw_rectangle(x-2, y, x+2, y, true)
draw_rectangle(x, y-2, x, y+2, true)

draw_set_color(c_white)
draw_set_alpha(1)
