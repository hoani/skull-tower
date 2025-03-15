
image_yscale = clamp(image_yscale + growth, 0, 1)
image_xscale = clamp(image_xscale + growth, 0, 1)


if lateral_update() {

    x += dx;
    y += dy;
    
    if x > room_width + width || x < -width || y > room_height + height || y < -height {
        instance_destroy()
    }
}

