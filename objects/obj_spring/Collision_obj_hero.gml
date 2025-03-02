if state.current == SPRING_FIRED {
    return
}

state_set(state, SPRING_FIRED)

var _dir = (other.g.dir + 180 + image_angle) % 360;

other.spd.x = impulse*dcos(_dir)
other.spd.y = -impulse*dsin(_dir)
other.lateral.cooldown = 8
other.jump.double = true;
other.jump.auto_boost = true
other.jump.auto_boost = true

if !audio_is_playing(snd_push) {
    create_sfx(x, y, snd_push)
}
