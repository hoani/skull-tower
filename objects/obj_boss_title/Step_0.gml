
state_update(state)

switch state.current {
    case S_FADE_IN:
        if state.step >= BOSS_TITLE_FADE_COUNT {
            state_set(state, S_WAIT);
            //sfx_create(x, y, snd_boss_intro, 1)
        }
        break;
    case S_WAIT:
        if state.step >= BOSS_TITLE_WAIT_COUNT {
            state_set(state, S_FADE_OUT);
        }
        break;
    case S_FADE_OUT:
        if state.step >= BOSS_TITLE_FADE_COUNT {
            instance_destroy();
        }
        break;
}


