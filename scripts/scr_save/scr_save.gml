function save_game(){
    var data = {
        deaths: stats_deaths(),
        frames: stats_frames(),
        room: room,
    }
    
    var _string = json_stringify(data);
    var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_save(_buffer, "skull-save.sav");
    buffer_delete(_buffer);
}

function load_game(){
    
}