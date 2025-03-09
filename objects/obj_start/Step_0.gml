
state_update(state)

switch state.current {
    case state_title: 
        if commands_continue_check() {
            state_set(state, state_fade)
        }
        break;
    case state_fade: 
    case state_story0_fade:    
    case state_story1_fade:     
    case state_story2_fade:
        if state.step >= fade_frames {
            state_set(state, state.current + 1)
            story_index++
            text_index = 0
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
}


