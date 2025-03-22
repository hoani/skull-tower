

function wrath_controller_update(_state) {
    var _boss_index = BI_WRATH;
    var _obj_intro = obj_wrath_intro;
    var _obj_boss = obj_wrath;
    var _music = MUSIC_WRATH;
    
    if boss_registry_get(_boss_index) == BOSS_DEFEAT && !instance_exists(obj_boss_die) {
        with(obj_door_block) {
            instance_destroy()
        }
        instance_destroy()
        obj_hero.disable = false
        return;
    }
    
    switch _state.current {
    case BOSS_CONTROLLER_PREINTRO:
        obj_hero.disable = true
        obj_hero.hspd = 0
        if _state.mono > 30 {
            state_set(_state, BOSS_CONTROLLER_INTRO)
            _obj_intro.active = true
        }
        break
    case BOSS_CONTROLLER_INTRO:
        if !instance_exists(_obj_intro) {
            boss_registry_set(_boss_index, BOSS_FIGHT)
            if !audio_is_playing(_music) {
                music_start(_music)
            }
            state_set(_state, BOSS_CONTROLLER_FIGHT)
            obj_hero.disable = false
        }
        break
    case BOSS_CONTROLLER_FIGHT:
        if !instance_exists(_obj_boss) {
            state_set(_state, BOSS_CONTROLLER_COMPLETE)
            music_fade_out(1000)
            boss_registry_set(_boss_index, BOSS_DEFEAT)
        }
        break
    case BOSS_CONTROLLER_COMPLETE:
        break;
    }
}
