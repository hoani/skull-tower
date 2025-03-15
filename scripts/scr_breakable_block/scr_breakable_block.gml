function moving_block_breakable() {
    
   
    x += dx;
    y += dy;
}

function do_moving_block_break() {
    var delta = 4;
    for (var i = min(x0, x1, x2, x3); i <= max(x0, x1, x2, x3); i+=delta) {
        for (var j = min(y0, y1, y2, y3); j <= max(y0, y1, y2, y3); j+=delta) {
            instance_create_mblocks(i, j, obj_part_fade, {
                depth: depth - 1,
                xspd: -dx/16,
                yspd: -dy/16,
                scale: 1/4,
                image_angle: irandom(360),
                image_blend: irandom(2) ? C_BLUE : (irandom(1) ? C_GRAY : C_LTGRAY),
            })   
        }
    }
    create_sfx(snd_crash, x, y)
    instance_destroy()
}