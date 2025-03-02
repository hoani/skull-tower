
state_update(state)

switch state.current {
    case BOSS_DIE_TWITCH:
        if state.step >= BOSS_DIE_TWITCH_COUNT {
            state_set(state, BOSS_DIE_FADE);
            create_sfx(x, y, snd_boss_defeat)
        }
        break;
    case BOSS_DIE_FADE:
        if state.step >= BOSS_DIE_FADE_COUNT {
            create_sfx(room_width/2, room_height/2, snd_boss_victory)
            instance_destroy()
            obj_control.boss_hp = new_hp(0, 0, function(){})
        }
        break;
}


