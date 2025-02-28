var _x = x

var _smod = state.step % 55;
if _smod < 16 {
    _x += 2*sin(2*pi*_smod/8)
}





switch state.current {
    
    case BOSS_DIE_TWITCH:
        draw_sprite(sprite_index, 0, _x, y) ;
        break;
    case BOSS_DIE_FADE:
        var _frac = state.step/BOSS_DIE_FADE_COUNT;
        shader_set(shd_dissolve);
        var _uniform_frac = shader_get_uniform(shd_dissolve, "frac");
        shader_set_uniform_f(_uniform_frac, _frac);
        
        
        draw_sprite(sprite_index, 0, _x, y);
        shader_reset();
        
        
        break;
}




