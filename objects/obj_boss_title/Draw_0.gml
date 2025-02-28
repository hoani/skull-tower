


var _frac = 0;
var _y = y;


switch state.current {
    
    case S_FADE_IN:
        _frac = 1.0 - state.step/BOSS_TITLE_FADE_COUNT;
        break;
    case S_WAIT:
        break;
    case S_FADE_OUT:
        _frac = state.step/BOSS_TITLE_FADE_COUNT;
        _y -= state.step/4.0;
        break;
}

shader_set(shd_dissolve);
var _uniform_frac = shader_get_uniform(shd_dissolve, "frac");
shader_set_uniform_f(_uniform_frac, _frac);


draw_sprite(sprite_index, 0, x, _y);
shader_reset();

