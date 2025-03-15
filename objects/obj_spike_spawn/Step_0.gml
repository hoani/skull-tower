if active && countdown != 0 {
    countdown = max(countdown - global.s, 0);
    if countdown == 0 {
        image_speed = 1;
    }
}
