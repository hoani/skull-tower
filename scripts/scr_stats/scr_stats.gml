function init_stats(){
    global.stats = {
        start_mono: 0,
        deaths: 0,
    }
}

#macro AWARD_WARRIOR (0)
#macro AWARD_HERO (1)
#macro AWARD_GOLDEN_HERO (2)
#macro AWARD_BONE_KING (3)


function stats_reset() {
    boss_registry_init() // Reinit the boss registry.
    global.stats = {
        start_mono: global.mono,
        deaths: 0,
    }
}

function stats_set(deaths, frames) {
    global.stats.start_mono = global.mono - frames 
    global.stats.deaths = deaths
}

function stats_increment_death() {
    global.stats.deaths++
}

function stats_deaths() {
    return global.stats.deaths
}

function stats_award() {
    if global.stats.deaths == 0 {
        return AWARD_BONE_KING
    }
    if global.stats.deaths < 25 {
        return AWARD_GOLDEN_HERO
    }
    if global.stats.deaths < 100 {
        return AWARD_HERO
    }
    return AWARD_WARRIOR
}

function stats_frames() {
    return global.mono - global.stats.start_mono
}


function stats_time_string() {
    var delta = global.mono - global.stats.start_mono
    var seconds = (delta/60)%60;
    var minutes = floor(delta/3600);
    
    var sec_str = string_replace(string_format(seconds, 2, 2), " ", "0");
    
    return $"{minutes}:{sec_str}"
}


function stats_draw_play() {
    draw_set_font(fnt_timer)
    draw_set_color(c_white)
    draw_set_halign(fa_center)
    draw_set_valign(fa_top)
    
    var _x = room_width/2;
    
    if instance_exists(obj_next_room) {
        if obj_next_room.image_angle == 90 && obj_next_room.x > room_width/4{
            draw_set_halign(fa_left)
            _x = 0;
        }
    }
    
    
    draw_text(_x, 0, stats_time_string())
}



