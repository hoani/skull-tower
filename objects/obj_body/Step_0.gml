

if !disable {
    commands_update(cmds);
    attack_update(); 
    body_update(cmds);
}

update_attack_slash()

sfx_update(sfx_run, x, y)

state_update(state);

if state.current == B_RUN {
    if snd_run_id == -1 {
        snd_run_id = sfx_loop(sfx_run, snd_run);
    }
} else {
    if snd_run_id != -1 {
        audio_stop_sound(snd_run_id)
        snd_run_id = -1
    }
}






