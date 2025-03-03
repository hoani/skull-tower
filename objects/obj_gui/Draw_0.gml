

if instance_exists(obj_hero) && room != rm_start {
    stats_draw_play()
}



if obj_control.boss_hp.max > 0 {
    hp_draw(room_width-4, 4, obj_control.boss_hp, spr_boss_health)	
}

draw_room_resetter()
