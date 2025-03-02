if instance_exists(obj_hero) && !triggered {
    var x_dist = min(abs(x0 - obj_hero.x), abs(x1 - obj_hero.x))
    if x_dist < 4 && obj_hero.y > y && collision_line(x, y, obj_hero.x, obj_hero.y, obj_block, true, true) == noone {
        triggered = true
    }
}

if triggered && countdown > 0 {
    countdown -= global.s
    if countdown <= 0 {
        disable = false
    }
}


