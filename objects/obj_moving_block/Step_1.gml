
// Platforms always move first - this way we know that the character's state is valid going into character movement.

moving_block_update()

if global.debug {
    if keyboard_check_pressed(ord("Q")) {
        xspd = -xspd;
        yspd = -yspd;
    }
}
