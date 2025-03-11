state_update(state)

switch state.current {
    case state_scroll: {
        y++
        if y >= room_height/2 {
            y = room_height/2
            state_set(state, state_pause)
            create_sfx(snd_boot, x, y)
        }
        break;
    }
    case state_pause: {
        if state.mono > 120 {
            room_goto_next()
        }
        break;
    }
}
