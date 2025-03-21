
function sloth_disable_moving_platforms() {
    with(obj_moving_block) {
        disable = true
    }
    with(obj_bone_ledge) {
        disable = true
    }
}

function sloth_enable_moving_platforms() {
    with(obj_moving_block) {
        disable = false
    }
    with(obj_bone_ledge) {
        disable = false
    }
}


function sloth_controller_update(_state) {
    
    if boss_registry_get(BI_SLOTH) == BOSS_DEFEAT && !instance_exists(obj_boss_die){
        with(obj_door_block) {
            instance_destroy()
        }
        sloth_disable_moving_platforms()
        with(obj_spikes) {
            instance_destroy()
        }
        with(obj_spike_spawn) {
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
            sloth_enable_moving_platforms()
        }
        break
    case BOSS_CONTROLLER_FIGHT:
        if !instance_exists(obj_sloth) {
            state_set(_state, BOSS_CONTROLLER_COMPLETE)
            music_fade_out(1000)
            
            sloth_disable_moving_platforms()
            with(obj_spikes) {
                instance_destroy()
            }
            with(obj_spike_spawn) {
                instance_destroy()
            }
            boss_registry_set(BI_SLOTH, BOSS_DEFEAT)
        }
        break
    case BOSS_CONTROLLER_COMPLETE:
        if !instance_exists(obj_boss_die) {
            // Setup next room trigger.
            with(obj_door_block) {
                instance_destroy()
            }
            
            instance_destroy()
        }
        break;
    }
}
