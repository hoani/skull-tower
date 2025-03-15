if lateral_update() {
    x += dx
    y += dy
}

count-=global.s

if count <= 0 {
    instance_destroy()
}

image_xscale = scale * (count/lifetime)
image_yscale = scale * (count/lifetime)