
function get_block_contact(_x, _y, _gdir, _face, _inst) {
    // Sorry for this fuckery - but it should work.
    if (_gdir == (180 + _face*90)) {
        return {
            x: min(_inst.x0, _inst.x1, _inst.x2, _inst.x3) - w_2,
            y: _y,
        };
    } else if (_gdir == (180 - _face*90)) {
        return {
            x: max(_inst.x0, _inst.x1, _inst.x2, _inst.x3) + w_2,
            y: _y,
        };
    } else if (_gdir == (90 - _face*90)){
        return {
            x: _x, 
            y: max(_inst.y0, _inst.y1, _inst.y2, _inst.y3) + w_2,
        }
    } else {
       return {
            x: _x, 
            y: min(_inst.y0, _inst.y1, _inst.y2, _inst.y3) - w_2, 
        }; 
    }
}
