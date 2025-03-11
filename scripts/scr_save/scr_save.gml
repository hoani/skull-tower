
#macro SAVE_FILENAME "skull-save.sav"



function save_game() {
    var data = {
        deaths: stats_deaths(),
        frames: stats_frames(),
        room: room,
    }
    
    var _json = json_stringify(data);
    var _buffer = buffer_create(string_byte_length(_json) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _json);
    buffer_save(_buffer, SAVE_FILENAME);
    buffer_delete(_buffer);
}

function can_load() {
    return file_exists(SAVE_FILENAME)
}

function load_game() {
    if (file_exists(SAVE_FILENAME)) {
        var _buffer = buffer_load(SAVE_FILENAME);
        var _json = buffer_read(_buffer, buffer_string);
        buffer_delete(_buffer);
        
        var data = json_parse(_json);
        show_debug_message($"JSON: {_json}")
        show_debug_message($"data: {data}")
        stats_set(data.deaths, data.frames);
        trigger_room_transition(data.room);
        return true
    }
    return false
}