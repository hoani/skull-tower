function hero_die(){
    if state.current == H_DIE {
        return
    }
    instance_create(x, y, obj_hero_die, {
        image_angle: g.dir-270, 
        image_xscale: face,
        depth: depth,
    });
    state_set(state, H_DIE);
    disable = true;
}

function hero_draw(_x, _y) {
    switch state.current {
        case B_RUN:
            var img = animate(IMG_RUN_INDEX, IMG_RUN_NUM, IMG_RUN_RATE, state.step)
            draw_sprite_ext(spr_hero, img, _x, _y, face, image_yscale, g.dir-270, c_white, 1)
            break;
        case B_JUMP:
            draw_sprite_ext(spr_hero, IMG_JUMP_INDEX, _x, _y, face, image_yscale, g.dir-270, c_white, 1)
            break;
        case B_WALL:
            draw_sprite_ext(spr_hero, IMG_WALL_INDEX, _x, _y, face, image_yscale, g.dir-270, c_white, 1)
            break
        case B_HANG:
            draw_sprite_ext(spr_hero, IMG_HANG_INDEX, _x, _y, face, image_yscale, g.dir-270, c_white, 1)
            break
        case H_DIE:
            break;
        default:
            draw_sprite_ext(spr_hero, IMG_IDLE_INDEX, _x, _y, face, image_yscale, g.dir-270, c_white, 1)
            break
    }
}
