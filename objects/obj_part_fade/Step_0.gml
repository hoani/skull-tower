if lateral_update() {
    x += dx
    y += dy
}

count-=global.s

if count <= 0 {
    instance_destroy()
}