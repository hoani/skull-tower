


function screen_shake_init() {
    global.ss = {
        count: 0,
        duration: 0,
        rep: 1,
        xamp: 0,
        yamp: 0,
    }
}

function screen_shake_x(amp, duration=16, rep=1) {
    global.ss.count = 0
    global.ss.xamp = amp
    global.ss.yamp = 0
    global.ss.duration = duration
    global.ss.rep = rep
}

function screen_shake_y(amp, duration=16, rep=1) {
    global.ss.count = 0
    global.ss.xamp = 0
    global.ss.yamp = amp
    global.ss.duration = duration
    global.ss.rep = rep
}


function update_screen_shake() {
    if global.ss.duration == 0 {
        return
    }
    
    global.ss.count+=1
    if global.ss.count > global.ss.duration*global.ss.rep {
        global.ss.duration = 0
        global.ss.count = 0
        global.ss.xamp = 0
        global.ss.yamp = 0
    }
}


function draw_screen_shake() {
    if global.ss.duration == 0 {
        return
    }
    
    var _a = sin(2*pi*global.ss.count/global.ss.duration);
    
    var _x = global.ss.xamp * _a;
    var _y = global.ss.yamp * _a;
    


    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_color(c_white);

    draw_surface(application_surface, _x, _y)
}