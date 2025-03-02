countdown = max(0, countdown - 1)
if countdown == 0 {
    moving = true
}

if !moving{
    image_angle = point_direction(x, y, obj_hero.x, obj_hero.y);
} else {
    direction = image_angle
    speed = min(speed + 0.125, 4);
}
