if (instance_exists(obj_hero) || instance_exists(obj_hero_spawner)) && !audio_is_playing(snd_music_castle) {
    if !instance_exists(obj_boss_controller) {
         music_start(snd_music_castle)
    }
   
}

if room == rm_ending {
    music_start(snd_music_ending)
}
