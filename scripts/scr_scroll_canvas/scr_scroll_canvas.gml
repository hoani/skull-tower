
#macro SCROLL_COUNT (16)


function scroll_canvas_init() {
    global.sc = {
        prev: surface_create(room_width, room_height), 
        scroll: 0,
        direction: 0,
    }
}

function update_scroll_canvas() {
    var _scroll_prev = global.sc.scroll;
    global.sc.scroll = max(0, global.sc.scroll - 1)
    if instance_exists(obj_hero){
         if global.sc.scroll != 0 {
             obj_hero.disable = true;
         } else {
             if global.sc.scroll != _scroll_prev && !instance_exists(obj_boss_controller) {
                 obj_hero.disable = false;
             }
         }
    }
}

function trigger_scroll_canvas(dir) {
    if !surface_exists(global.sc.prev) {
        global.sc.prev = surface_create(room_width, room_height)
    }
    surface_copy(global.sc.prev, 0, 0, application_surface);
    global.sc.direction = dir;
    global.sc.scroll = SCROLL_COUNT;
}


function draw_scroll_canvas() {
    if global.sc.scroll == 0 {
        return
    }
    
    var _x = -dcos(global.sc.direction);
    var _y = dsin(global.sc.direction);
    
    var _frac = global.sc.scroll/SCROLL_COUNT;
    if surface_exists(global.sc.prev) {
        draw_surface(global.sc.prev, _x*(1.0-_frac)*room_width, _y*(1.0-_frac)*room_width)
    } else {
        // Backup.
        draw_set_color(C_BLACK);
        draw_set_alpha(1);
        draw_rectangle(0, 0, room_width, room_height, false);
        draw_set_color(C_WHITE);
    }
    draw_surface(application_surface, _x*(-_frac)*room_width, _y*(-_frac)*room_width)
}