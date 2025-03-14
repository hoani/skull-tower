delete g;

if snd_run_id != -1 {
    audio_stop_sound(snd_run_id)
    snd_run_id = -1
}

sfx_cleanup(sfx_run)
