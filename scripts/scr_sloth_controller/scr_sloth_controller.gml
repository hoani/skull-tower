
function sloth_controller_update(_state) {
    switch phase {
    case BOSS_CONTROLLER_PREINTRO:
        if obj_hero.x > room_width/4 {
            state_set(_state, BOSS_CONTROLLER_INTRO)
            obj_sloth_intro.active = true
            set_state(STATE_CUTSCENE)
            obj_hero.hspd = 0
        }
        break
    case BOSS_CONTROLLER_INTRO:
        if !instance_exists(obj_sloth_intro) {
            music_start(snd_music_fallen)
            boss_controller_set_phase(BOSS_CONTROLLER_PHASE_FIGHT)
            set_state(STATE_PLAY)
            with(obj_fallen_block) {
                activate_fallen_block()
            }
        }
        break
    case BOSS_CONTROLLER_PHASE_FIGHT:
        if !instance_exists(obj_fallen) {
            boss_controller_set_phase(BOSS_CONTROLLER_PHASE_COMPLETE)
            music_fade_out(1000)
            with(obj_fallen_block) {
                stop = true	
            }
            with(obj_spike) {
                instance_destroy()
            }
        }
        break
    case BOSS_CONTROLLER_PHASE_COMPLETE:
        if !instance_exists(obj_boss_die) {
            obj_next_prompt.alarm[0] = 300
            
            with(obj_next_block) {
                instance_destroy()
            }
            
            instance_destroy()
        }
        break;
    }
