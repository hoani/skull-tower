/// @description Insert description here
// You can write your code in this editor

game_init()

init_stats()

global.p = self

global.g = new Gravity(0.125, 270);

boss_hp = new_hp(0, 0, function (){});

scroll_canvas_init()
screen_shake_init()

room_resetter_init()
