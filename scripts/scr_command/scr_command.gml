// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#macro CMD_LEFT "hk_left"
#macro CMD_RIGHT "hk_right"
#macro CMD_UP "hk_up"
#macro CMD_DOWN "hk_down"
#macro CMD_A "hk_a"
#macro CMD_B "hk_b"
#macro CMD_JUMP "hk_jump"


#macro ACTION_KEY ord("Z")
#macro ALT_ACTION_KEY ord("W")

#macro BLOCK_KEY ord("X")


function commands_continue_check() {
	var _gp_input = gamepad_is_supported() && gamepad_is_connected(0) && (
	gamepad_button_check_pressed(0, gp_start) || 
	gamepad_button_check_pressed(0, gp_select) ||
	gamepad_button_check_pressed(0, gp_face1) || 
	gamepad_button_check_pressed(0, gp_face2) || 
	gamepad_button_check_pressed(0, gp_face3) || 
	gamepad_button_check_pressed(0, gp_face4)
	);
    var _kb_input = keyboard_check_pressed(ACTION_KEY) || 
        keyboard_check_pressed(ALT_ACTION_KEY) || 
        keyboard_check_pressed(BLOCK_KEY) ||
        keyboard_check_pressed(vk_space) ||
        keyboard_check_pressed(vk_enter)
        
	return _gp_input || _kb_input;	
}
	


function commands_init() {
	var _cmds = {
		checks: {
			CMD_LEFT: [],
			CMD_RIGHT: [],
			CMD_UP: [],
			CMD_DOWN: [],
			CMD_A: [],
			CMD_B: [],			
            CMD_JUMP: [],
		},
		state: {
			CMD_LEFT: {pressed: false, check: false, released: false},
			CMD_RIGHT: {pressed: false, check: false, released: false},
			CMD_UP: {pressed: false, check: false, released: false},
			CMD_DOWN: {pressed: false, check: false, released: false},
			CMD_A: {pressed: false, check: false, released: false},
			CMD_B: {pressed: false, check: false, released: false},
            CMD_JUMP: {pressed: false, check: false, released: false},
		},
		gamepad: -1,
		check: function(_cmd){return false},
		check_pressed: function(_cmd){return false},
		check_released: function(_cmd){return false},
	}
	
	_cmds.check = function(_cmd){return commands_check(_cmds, _cmd)}
	_cmds.check_pressed = function(_cmd){return commands_check_pressed(_cmds, _cmd)}
	_cmds.check_released = function(_cmd){return commands_check_released(_cmds, _cmd)}

	
	return _cmds
}

function commands_register_single_player(_cmds) {
	commands_register(_cmds, CMD_LEFT, function(_cmds){return keyboard_check(vk_left)});
	commands_register(_cmds, CMD_RIGHT, function(_cmds){return keyboard_check(vk_right)})
	commands_register(_cmds, CMD_UP, function(_cmds){return keyboard_check(vk_up)})
	commands_register(_cmds, CMD_DOWN, function(_cmds){return keyboard_check(vk_down)})
	commands_register(_cmds, CMD_A, function(_cmds){return keyboard_check(ACTION_KEY)})
	commands_register(_cmds, CMD_A, function(_cmds){return keyboard_check(ALT_ACTION_KEY)})
	commands_register(_cmds, CMD_B, function(_cmds){return keyboard_check(BLOCK_KEY)})
    commands_register(_cmds, CMD_JUMP, function(_cmds){return keyboard_check(ord("C"))})
}

function has_controller(_cmds) {
	return _cmds.gamepad != -1
}

function connect_gamepad(_cmds, _index) {
	if _cmds.gamepad != -1 {
        _cmds.gamepad = _index
		return
	}
	
	_cmds.gamepad = _index
	commands_register(_cmds, CMD_LEFT, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_padl)});
	commands_register(_cmds, CMD_RIGHT, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_padr)});
	commands_register(_cmds, CMD_UP, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_padu)});
	commands_register(_cmds, CMD_DOWN, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_padd)});
	commands_register(_cmds, CMD_A, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_face1)});
	commands_register(_cmds, CMD_JUMP, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_face2)});
	commands_register(_cmds, CMD_JUMP, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_face3)});
	commands_register(_cmds, CMD_A, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_face4)});
    commands_register(_cmds, CMD_B, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_shoulderl)});
    commands_register(_cmds, CMD_B, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_shoulderr)});
    commands_register(_cmds, CMD_B, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_shoulderlb)});
    commands_register(_cmds, CMD_B, function(_cmds){return gamepad_button_check(_cmds.gamepad, gp_shoulderrb)});
}

function commands_update(_cmds) {
	commands_input_update(_cmds, CMD_LEFT);
	commands_input_update(_cmds, CMD_RIGHT);
	commands_input_update(_cmds, CMD_UP);
	commands_input_update(_cmds, CMD_DOWN);
	commands_input_update(_cmds, CMD_A);
	commands_input_update(_cmds, CMD_B);	
    commands_input_update(_cmds, CMD_JUMP);
}

function commands_input_update(_cmds, _cmd) {
	var _last = struct_get(_cmds.state, _cmd).check;
	var _check = false;
	var _checks = struct_get(_cmds.checks, _cmd);
	for (var _i=0; _i<array_length(_checks); _i++) {
		_check |= _checks[_i](_cmds);
	}
	
	var _pressed = _check && (_last != _check);	
	var _released = !_check && (_last != _check);
	struct_set(_cmds.state, _cmd, {pressed: _pressed, check: _check, released: _released});
}

function commands_register(_cmds, _cmd, _check) {
	var _arr = struct_get(_cmds.checks, _cmd);
	
	array_push(_arr, _check);
	struct_set(_cmds.checks, _cmd, _arr);
}

function commands_check(_cmds, _cmd) {
	return struct_get(_cmds.state, _cmd).check;
}

function commands_check_pressed(_cmds, _cmd) {
	return struct_get(_cmds.state, _cmd).pressed;
}

function commands_check_released(_cmds, _cmd) {
	return struct_get(_cmds.state, _cmd).released;
}



