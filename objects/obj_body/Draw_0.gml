switch state.current {
    case B_RUN:
        var img = animate(0, 4, 16, state.step)
        draw_sprite_ext(spr_hero_run, img, x, y, face, image_yscale, g.dir-270, c_white, 1)
        break;
    case B_JUMP:
        draw_sprite_ext(spr_hero_jump, 0, x, y, face, image_yscale, g.dir-270, c_white, 1)
        break;
    case B_WALL:
        draw_sprite_ext(spr_hero_wall, 0, x, y, face, image_yscale, g.dir-270, c_white, 1)
        break
    case B_HANG:
        draw_sprite_ext(spr_hero_hang, 0, x, y, face, image_yscale, g.dir-270, c_white, 1)
        break
    default:
        draw_sprite_ext(spr_hero, 0, x, y, face, image_yscale, g.dir-270, c_white, 1)
        break
}




draw_set_color(c_white);
draw_set_halign(fa_center)
draw_text(x, y +12, state.current)

if f.floor.inst != noone {
    draw_set_color(c_fuchsia)
    draw_set_alpha(0.5)
    draw_rectangle(f.floor.inst.x, f.floor.inst.y, f.floor.inst.x+15, f.floor.inst.y+15, false);
}

if f.wall.left != noone {
    draw_set_color(c_blue)
    draw_set_alpha(0.5)
    draw_rectangle(f.wall.left.x, f.wall.left.y, f.wall.left.x+12, f.wall.left.y+12, false);
}

if f.wall.right != noone {
    draw_set_color(c_teal)
    draw_set_alpha(0.5)
    draw_rectangle(f.wall.right.x, f.wall.right.y, f.wall.right.x+12, f.wall.right.y+12, false);
}

if f.roof != noone {
    draw_set_color(c_green)
    draw_set_alpha(0.5)
    draw_rectangle(f.roof.x, f.roof.y, f.roof.x+8, f.roof.y+8, false);
}

draw_set_color(c_white)
draw_set_alpha(1)


return

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


