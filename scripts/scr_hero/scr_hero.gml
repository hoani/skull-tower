function hero_die(){
    if state.current == H_DIE {
        return
    }
    
    instance_create_hero(x, y, obj_hero_die, {
        image_angle: g.dir-270, 
        image_xscale: face,
        depth: depth,
    });
    state_set(state, H_DIE);
    disable = true;
    obj_control.boss_hp = new_hp(0, 0, function(){})
    stats_increment_death()
    
}

function get_hero_jump_index() {
    if spd.y >= 0.75 {
        return IMG_JUMP_INDEX + 5;
    }
    if spd.y >= 5/16 {
        return IMG_JUMP_INDEX + 4;
    }
    if spd.y >= 0 {
        return IMG_JUMP_INDEX + 3;
    }
    if spd.y >= -5/16 {
        return IMG_JUMP_INDEX + 2;
    }
    if spd.y >= -0.75 {
        return IMG_JUMP_INDEX + 1;
    }
    return IMG_JUMP_INDEX + 0;
}

function hero_draw(_x, _y) {
    var spr = jump.double ? spr_hero : spr_hero_alt;
    var img = IMG_IDLE_INDEX;
    switch state.current {
        case B_RUN:
            img = animate(IMG_RUN_INDEX, IMG_RUN_NUM, IMG_RUN_RATE, state.step)
            draw_hero_sprite(spr, img, _x, _y)
            break;
        case B_JUMP:
            img = get_hero_jump_index()
            draw_hero_sprite(spr, img, _x, _y)
            break;
        case B_WALL:
            draw_hero_sprite(spr, IMG_WALL_INDEX, _x, _y)
            break
        case B_HANG:
            draw_hero_sprite(spr, IMG_HANG_INDEX, _x, _y)
            break
        case B_DASH:
            draw_hero_sprite(spr, IMG_DASH_INDEX, _x, _y)
            break
        case B_ATTACK:
            hero_draw_attack(_x, _y);
            break
        case H_DIE:
            break;
        default:
            if landing.cooldown != 0 {
                img = animate(IMG_LANDING_INDEX, IMG_LANDING_NUM, IMG_LANDING_RATE, landing.cooldown_frames - landing.cooldown)
            } else {
                if y_drop {
                    img = 1;
                }
                if y_up {
                    img = 2;
                }
            }
            draw_hero_sprite(spr, img, _x, _y)
            break
    }
}

function draw_hero_sprite(_spr, _img, _x, _y) {
    draw_sprite_ext(_spr, _img, _x, _y, face, image_yscale, g.dir-270, c_white, 1)
}

function hero_draw_attack(_x, _y) {
    var index = 0;
    switch attack.state.current {
        case ATTACK_START:
            index = IMG_ATTACK_START_INDEX;
            break;
        case ATTACK_SLASH:
            index = IMG_ATTACK_SLASH_INDEX;
            break;
        case ATTACK_STAB:
            index = IMG_ATTACK_STAB_INDEX;
            break;
        case ATTACK_SWING:
            index = IMG_ATTACK_SWING_INDEX;
            break;
        case ATTACK_RECOVER:
            index = animate(IMG_ATTACK_RECOVER_INDEX, IMG_ATTACK_RECOVER_NUM, IMG_ATTACK_RECOVER_RATE, attack.state.step);
            break;
    }
    var spr = jump.double ? spr_hero_attack : spr_hero_attack_alt;
    draw_hero_sprite(spr, index, _x, _y)
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
        instance_create_sfx(x + vec.x*dist, y + vec.y*dist, obj_hero_shadow, {
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
        });
        
        dist += 4 + dash.distance/8;
    }
}
