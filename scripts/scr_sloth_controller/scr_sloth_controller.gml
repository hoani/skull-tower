
function sloth_controller_update(_state) {
    
    if boss_registry_get(BI_SLOTH) == BOSS_DEFEAT {
        with(obj_door_block) {
            instance_destroy()
        }
        with(obj_moving_block) {
            disable = true
        }
        with(obj_spikes) {
            instance_destroy()
        }
        instance_destroy()
        return;
    }
    
    switch _state.current {
    case BOSS_CONTROLLER_PREINTRO:
        obj_hero.disable = true
        obj_hero.hspd = 0
        if _state.mono > 30 {
            state_set(_state, BOSS_CONTROLLER_INTRO)
            obj_sloth_intro.active = true
        }
        break
    case BOSS_CONTROLLER_INTRO:
        if !instance_exists(obj_sloth_intro) {
            boss_registry_set(BI_SLOTH, BOSS_FIGHT)
            if !audio_is_playing(MUSIC_SLOTH) {
                music_start(MUSIC_SLOTH)
            }
            state_set(_state, BOSS_CONTROLLER_FIGHT)
            obj_hero.disable = false
            with(obj_moving_block) {
                disable = false
            }
        }
        break
    case BOSS_CONTROLLER_FIGHT:
        if !instance_exists(obj_sloth) {
            state_set(_state, BOSS_CONTROLLER_COMPLETE)
            music_fade_out(1000)
            
            with(obj_moving_block) {
                disable = true
            }
            with(obj_spikes) {
                instance_destroy()
            }
            
        }
        break
    case BOSS_CONTROLLER_COMPLETE:
        if !instance_exists(obj_boss_die) {
            // Setup next room trigger.
            with(obj_door_block) {
                instance_destroy()
            }
            boss_registry_set(BI_SLOTH, BOSS_DEFEAT)
            
            instance_destroy()
        }
        break;
    }
}
