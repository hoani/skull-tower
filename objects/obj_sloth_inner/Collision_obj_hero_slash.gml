if invincibility > 0 {
    return
}

create_sfx(x, y, snd_boss_damage)

instance_destroy()

with(obj_sloth_inner) {
    invincibility = 20;
}

with(obj_hero) {
    var _dir = point_direction(other.x, other.y, x, y)
    
    spd.x = 2*dcos(_dir)
    lateral.cooldown = 8
    spd.y = clamp(-2* dsin(_dir), -2, 0.5);
}
