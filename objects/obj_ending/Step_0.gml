
state_update(state)

switch state.current {
    case state_wait: 
        if state.step > 30 {
            state_set(state, state_story0)
        }
        break;
    case state_story0:
        story_index = min(story_index + 1, string_length(story_text[0]))
        if state.step > story_duration {
            state_set(state, state_story1)
            story_index = 0;
        }
        break;
    case state_story1:
        story_index = min(story_index + 1, string_length(story_text[1]))
        if state.step > story_duration {
            state_set(state, state_story2)
            story_index = 0;
        }
        break;
    case state_story2:
        story_index = min(story_index + 1, string_length(story_text[2]))
        if state.step > story_duration {
            state_set(state, state_credits)
        }
        break;
    case state_credits:
        if commands_continue_check() {
            trigger_room_transition(rm_boot)
        }
        break;
}


