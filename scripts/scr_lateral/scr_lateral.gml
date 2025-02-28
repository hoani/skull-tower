function lateral_init(){
    xmove = 0;
    ymove = 0;
    
    dx = 0;
    dy = 0;
}

function lateral_update() {
    xmove += xspd *global.s;
    dx = sign(xmove) * floor(abs(xmove));
    xmove -= dx;
    
    ymove += yspd *global.s;
    dy = sign(ymove) * floor(abs(ymove));
    ymove -= dy;
    
    if dx == 0 && dy == 0 {
        return false;
    }
    
    return true
}
