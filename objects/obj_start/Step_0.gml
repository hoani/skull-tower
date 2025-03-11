
state_update(state)


function menu_move(amt) {
    menu_index += amt
    menu_last_step = state.step 
    create_sfx(snd_menu_move)
    var menu_min = continue_enabled ? 0:1;
    menu_index = clamp(menu_index, menu_min, menu_num-1)
}


switch state.current {
    case state_title:
        with (obj_hero) {
            disable = true
        }
        commands_update(global.cmds)
        if commands_check_pressed(global.cmds, CMD_UP) {
            menu_move(-1);
        }
        if commands_check_pressed(global.cmds, CMD_DOWN) {
            menu_move(+1);
        }
        var _allow_hold = (state.step - menu_last_step) > menu_hold_frames
        if commands_check(global.cmds, CMD_UP) && _allow_hold  {
            menu_move(-1);
        }
        if commands_check(global.cmds, CMD_DOWN) && _allow_hold {
            menu_move(+1);
        }
        
        if commands_continue_check() {
            create_sfx(snd_menu_select)
            if menu_index == menu_item_credits {
                state_set(state, state_credits_selected)
            } else if menu_index == menu_item_continue {
                state_set(state, state_continue_selected)
            } else {
                state_set(state, state_new_selected)
            }
        }
        
        break;
    case state_new_selected:
    case state_continue_selected: 
    case state_credits_selected:
        if state.step >= selected_frames {
            state_set(state, state.current + 1)
        }
        break;
    case state_new:
    case state_story0_fade:    
    case state_story1_fade:     
    case state_story2_fade:
        if state.step >= fade_frames {
            state_set(state, state.current + 1)
            story_index++
            text_index = 0
            with (obj_hero) {
                disable = false
            }
        }
        break;
    case state_story0:
    case state_story1:
    case state_story2:
        if state.step % character_frames == 0 {
            text_index = min(text_index + 1, string_length(story_text[story_index]))
        }
        if (state.step > min_story_duration && commands_continue_check()) || state.step > max_story_duration {
            state_set(state, state.current + 1)
        }
        break;
    
    case state_idle:
        break;
    case state_continue:
        if !load_game() {
            state_set(state, state_new) // fallback in case continuing fails.
        }
        break;
    case state_credits:
        if commands_continue_check() {
            state_set(state, state_credits_fade)
        }
        break;
    case state_credits_fade:
        if state.step >= fade_frames*2 {
            state_set(state, state_title)
        }
        break;
}


