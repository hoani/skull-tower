function lateral_init(){
    xmove = 0;
    ymove = 0;
    
    dx = 0;
    dy = 0;
}

function lateral_update() {
    return base_lateral_update(xspd, yspd);
}

function base_lateral_update(_xspd, _yspd) {
    xmove += _xspd *global.s;
    dx = sign(xmove) * floor(abs(xmove));
    xmove -= dx;
    
    ymove += _yspd *global.s;
    dy = sign(ymove) * floor(abs(ymove));
    ymove -= dy;
    
    if dx == 0 && dy == 0 {
        return false;
    }
    
    return true
}
