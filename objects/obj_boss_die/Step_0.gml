
state_update(state)

switch state.current {
    case BOSS_DIE_TWITCH:
        if state.step >= BOSS_DIE_TWITCH_COUNT {
            state_set(state, BOSS_DIE_FADE);
            create_sfx(snd_boss_defeat, x, y)
        }
        break;
    case BOSS_DIE_FADE:
        if state.step >= BOSS_DIE_FADE_COUNT {
            create_sfx(snd_boss_victory)
            instance_destroy()
            obj_control.boss_hp = new_hp(0, 0, function(){})
        }
        break;
}


