
#macro RESET_COUNT (8)
#macro RESET_WAIT (4)


function room_resetter_init() {
    global.rr = {
        triggered: false,
        resetting: false,
        count: 0,
        target: -1,
    }
}

function trigger_room_transition(target) {
    global.rr.triggered = true;
    global.rr.resetting = true;
    global.rr.target = target;
}

function trigger_room_reset() {
    global.rr.triggered = true;
    global.rr.resetting = true;
    global.rr.target = -1;
}

function update_room_resetter() {
    if global.rr.triggered {
        global.rr.count += global.rr.resetting ? 1 : -1;
        if global.rr.resetting && global.rr.count >= (RESET_COUNT + RESET_WAIT) {
            global.rr.resetting = false
            global.rr.count = RESET_COUNT
            if global.rr.target = -1 {
                 room_restart()
            } else {
                room_goto(global.rr.target)
            }
           
        }
        if !global.rr.resetting && global.rr.count <= 0 {
            global.rr.count = 0;
            global.rr.resetting = false;
        }
    }
}


function draw_room_resetter() {
    if global.rr.count == 0 {
        return
    }
    
    var _frac = clamp(1.0 - global.rr.count/RESET_COUNT, 0, 1);
    shader_set(shd_dissolve);
    var _uniform_frac = shader_get_uniform(shd_dissolve, "frac");
    shader_set_uniform_f(_uniform_frac, _frac);
    
    draw_set_color(C_BLACK);
    draw_set_alpha(1);
    draw_rectangle(0, 0, room_width, room_height, false);
    
    shader_reset();
    
    draw_set_color(C_WHITE);
}




