
function simple_floor_angle(_x, _y, _w, _gdir){
    var _slope = slope_angle;
    var _v0 = _x;
    var _v1 = x1;
    if _gdir == 0 {
        _v0 = y0;
        _v1 = _y;
    }
    if _gdir == 90 {
        _v0 = x3;
        _v1 = _x;
    }
    if _gdir == 180 {
        _v0 = _y;
        _v1 = y2;
    }
    if abs(_v0 - _v1) <= _w/2 {
        return 0; // at peak, don't go up/down slope.
    }
    if _v0 > _v1 {
        return _slope - 90;
    } else {
        return _slope;
    }
}


function floor_init() {
    w = sprite_get_width(sprite_index)*image_xscale;
    h = sprite_get_height(sprite_index)*image_yscale;
    
    vcosc = dcos(image_angle);
    vsinc = dsin(image_angle);
    
    wc = w;
    hc = h;
    
    slope_angle = image_angle;
    
    if slope_angle > 90 {
        slope_angle -= 360;
    }
    
    while slope_angle < 0 {
        slope_angle += 90
        var wp = w;
        var hp = h;
        w = hp;
        h = wp;
    }
    
    vcos = dcos(slope_angle);
    vsin = dsin(slope_angle);
    
    xc = x + (vcosc*wc + vsinc*hc)/2;
    yc = y + (-vsinc*wc + vcosc*hc)/2;
    
    x0 = xc - (vcos*w + vsin*h)/2;
    y0 = yc - (-vsin*w + vcos*h)/2;
    
    x1 = xc + (vcos*w - vsin*h)/2;
    y1 = yc - (vsin*w + vcos*h)/2;
    
    x2 = xc + (vcos*w + vsin*h)/2;
    y2 = yc + (-vsin*w + vcos*h)/2;
    
    x3 = xc + (-vcos*w + vsin*h)/2;
    y3 = yc - (-vsin*w - vcos*h)/2;
}

function floor_update_coords() {
    xc = x + (vcosc*wc + vsinc*hc)/2;
    yc = y + (-vsinc*wc + vcosc*hc)/2;
    
    x0 = xc - (vcos*w + vsin*h)/2;
    y0 = yc - (-vsin*w + vcos*h)/2;
    
    x1 = xc + (vcos*w - vsin*h)/2;
    y1 = yc - (vsin*w + vcos*h)/2;
    
    x2 = xc + (vcos*w + vsin*h)/2;
    y2 = yc + (-vsin*w + vcos*h)/2;
    
    x3 = xc + (-vcos*w + vsin*h)/2;
    y3 = yc - (-vsin*w - vcos*h)/2;
}



function floor_draw_debug() {
    draw_self();
    
    draw_set_color(c_aqua);
    draw_line(x0, y0, x1, y1);
    
    
    draw_set_color(c_yellow);
    draw_line(x2, y2, x1, y1);
    
    draw_set_color(c_red);
    draw_line(x0, y0, x3, y3);
    
    
    draw_set_color(c_fuchsia);
    draw_line(x2, y2, x3, y3);
    
    draw_set_color(c_white);
}