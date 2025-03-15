event_inherited()

centered_floor_init()

do_move = moving_block_breakable

excludes = []

var list = ds_list_create();
var num = collision_rectangle_list(x0, y0, x2, y2, collision_obj, true, true, list, false);
for (var i = 0; i < num; i++) {
    var item = ds_list_find_value(list, i);
    array_push(excludes, ds_list_find_value(list, i));
}
ds_list_destroy(list);

if abs(xaccel) < 1/128 {
    xaccel = 0;
}

if abs(yaccel) < 1/128 {
    yaccel = 0;
}

break_triggered = false;
