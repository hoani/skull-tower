// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#macro FPS_FILTER 64


function debug_init() {
	global.debug = false
	global.diagnostics = false
    global.do_recording = false 
	global.show_gui = true
	
	fps_avg = 0
}

function debug_update() {
	fps_avg = (fps_avg * (FPS_FILTER - 1)/FPS_FILTER) + fps_real/FPS_FILTER 
}

function debug_draw() {
	if !global.debug || global.do_recording {
		return
	}
	if global.diagnostics {
        draw_set_halign(fa_left);
		draw_text(0, 0, string(fps_avg))
	}
}

#macro DEBUG_KEY_PAUSE vk_space
#macro DEBUG_KEY_FPS_UP ord("P")
#macro DEBUG_KEY_FPS_DOWN ord("O")
#macro DEBUG_KEY_SFX_TOGGLE ord("N")
#macro DEBUG_KEY_MUSIC_TOGGLE ord("M")
#macro DEBUG_KEY_RESET ord("R")
#macro DEBUG_KEY_NEXT_ROOM ord("0")
#macro DEBUG_KEY_PREV_ROOM ord("9")

function debug_control() {
	if !global.debug {
		return
	}
	
	if keyboard_check_pressed(DEBUG_KEY_PAUSE) {
		pause_toggle()
	}
	
	if keyboard_check_pressed(DEBUG_KEY_FPS_UP) {
		game_set_speed(game_get_speed(gamespeed_fps)*2.0, gamespeed_fps)
	}
	
	if keyboard_check_pressed(DEBUG_KEY_FPS_DOWN) {
		game_set_speed(game_get_speed(gamespeed_fps)*0.5, gamespeed_fps)
	}
    
    if keyboard_check_pressed(DEBUG_KEY_NEXT_ROOM) {
        if room == room_last {
            trigger_room_transition(room_first)
        } else {
            trigger_room_transition(room_next(room))
        }
    }
    
    if keyboard_check_pressed(DEBUG_KEY_PREV_ROOM) {
        if room == room_first {
            trigger_room_transition(room_last)
        } else {
            trigger_room_transition(room_previous(room))
        }
    }
	
	if keyboard_check_pressed(DEBUG_KEY_SFX_TOGGLE) {
		global.sfx.enabled = !global.sfx.enabled
		if global.sfx.enabled {
			sfx_enable()
		} else {
			sfx_disable()
		}
	}
	
	if keyboard_check_pressed(DEBUG_KEY_MUSIC_TOGGLE) {
		music_toggle()
	}
    
    if keyboard_check_pressed(DEBUG_KEY_RESET) {
            game_restart()
    }
	
}
