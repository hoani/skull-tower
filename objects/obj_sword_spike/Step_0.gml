
if pos == 0 {
    image_index = 0
    timer++
    if timer >= duration {
        pos=8
        create_sfx(x, y, snd_envy_spike_spawn)
    }
} else {
    pos = max(0, pos - 1/8)
    if pos == 0 {
        timer = 0
    }
}

image_index = pos > 2 ? 1 : 0

if image_angle = 0 {
    y = ystart - pos;
}

if image_angle = 90 {
    x = xstart - pos;
}

if image_angle = 180 {
    y = ystart + pos;
}

if image_angle = 270 {
    x = xstart + pos;
}
