function Gravity(_mag, _dir) constructor {
    mag = _mag;
    dir = _dir;
    x = 0;
    y = 0;
    
    static update_direction = function(_dir) {
        dir = _dir;
        x = dcos(_dir);
        y = -dsin(_dir);
    }
    
    update_direction(_dir); 

    static convert = function(spdx, spdy, f_grav) {
        if f_grav.x != x || f_grav.y != y {
            var spdx_prev = spdx;
            var spdy_prev = spdy;
            if (y == -f_grav.y  && y != 0) || (x == -f_grav.x && x != 0) {
                spdx = -spdx_prev;
                spdy = -spdy_prev;
            } else {
                spdx = -f_grav.y *x*spdy_prev + f_grav.x*y*spdy_prev;
                spdy = +f_grav.y *x*spdx_prev - f_grav.x*y*spdx_prev;
            }
        }
        return { x: spdx, y: spdy }
    }
}




