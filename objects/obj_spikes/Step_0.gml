if attached != noone {
    if !instance_exists(attached) {
        instance_destroy()
        return
    }
    x = xstart + (attached.x - attached.xstart)
    y = ystart + (attached.y - attached.ystart)
    floor_update_coords()
}
