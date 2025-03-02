var _dir = point_direction(x, y, other.x, other.y)

other.spd.x = 3*dcos(_dir)
other.lateral.cooldown = 8
other.spd.y = clamp(-2* dsin(_dir), -2, 0.5);


if !audio_is_playing(snd_push) {
    create_sfx(x, y, snd_push)
}
