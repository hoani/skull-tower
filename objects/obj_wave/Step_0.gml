
image_yscale = clamp(image_yscale + growth, 0, 1)
image_xscale = clamp(image_xscale + growth, 0, 1)

if image_xscale >  0.625 && image_yscale > 0.625 {
    active = true;
}


if lateral_update() {

    x += dx;
    y += dy;
    
    if x > room_width + width || x < -width || y > room_height + height || y < -height {
        instance_destroy()
    }
}

