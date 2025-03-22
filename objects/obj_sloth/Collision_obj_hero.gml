var _dir = point_direction(x, y, other.x, other.y)

other.spd.x = 2*dcos(_dir)
other.lateral.cooldown = 4
other.spd.y = clamp(-2* dsin(_dir), -2, 0.5);

if !audio_is_playing(snd_push) {
    create_sfx(snd_push, x, y)
}
