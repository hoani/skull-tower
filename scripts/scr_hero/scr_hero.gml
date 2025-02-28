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
        case B_DASH:
            draw_sprite_ext(spr_hero, IMG_DASH_INDEX, _x, _y, face, image_yscale, g.dir-270, c_white, 1)
            break
        case H_DIE:
            break;
        default:
            draw_sprite_ext(spr_hero, IMG_IDLE_INDEX, _x, _y, face, image_yscale, g.dir-270, c_white, 1)
            break
    }
}

function hero_draw_projection() {
    var vec = {x: (dash.x - x)/dash.distance, y: (dash.y - y)/dash.distance};
        var dist = dash.distance;
        
        while (dist > 4) {
            var _tex = sprite_get_texture(spr_hero, 0);
            var _tw = texture_get_texel_width(_tex);
            var _th = texture_get_texel_height(_tex);
            shader_set(shd_dash_projection);
            shader_set_uniform_f(shader_get_uniform(shd_dash_projection, "texel"), _tw, _th);
            shader_set_uniform_f(shader_get_uniform(shd_dash_projection, "color"), 229/256.0, 45/256.0, 64/256.0);
            hero_draw(x + vec.x*dist, y + vec.y*dist);
            
            shader_reset();
            
            dist -= 4 + dash.distance/8;
        }
}

function hero_create_after_shadow() {
    var vec = {x: (dash.x - x)/dash.distance, y: (dash.y - y)/dash.distance};
    var dist = 0;
    
    while (dist < dash.distance - 4) {
        instance_create(x + vec.x*dist, y + vec.y*dist, obj_hero_shadow, {
            image_angle: image_angle,
            image_yscale: face,
            image_index: IMG_DASH_INDEX,
            sprite_index: sprite_index,
            step: floor(SHADOW_FRAMES*(1.0-power(dist/dash.distance, 2))),
            r: 229/256.0, 
            g: 45/256.0, 
            b: 64/256.0,
            xspd: vec.x/8,
            yspd: vec.y/8,
            depth: depth + 1,
        });
        
        dist += 4 + dash.distance/8;
    }
}
