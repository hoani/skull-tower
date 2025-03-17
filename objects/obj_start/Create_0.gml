state_title = 0
state_continue_selected = 1
state_continue = 2
state_new_selected = 3
state_new = 4

state_story0 = 5
state_story0_fade = 6
state_story1 = 7
state_story1_fade = 8
state_story2 = 9
state_story2_fade = 10
state_idle = 11

state_credits_selected = 12
state_credits = 13
state_credits_fade = 14

min_story_duration = 300
max_story_duration = 600


state = new_state(state_title)

story_text = [
    "   Skeletrex has\n   been defeated\nand humanity knows\n  peace once again.",
    "   However, the\nseven bone generals\n  are plotting to\n revive Skeletrex.",
    "   Damn bonies!       \nHumanity needs a\n  true warrior to\n    defeat the\n  bone generals!",
];

story_index = -1;
text_index = 0;

award = stats_award()

time = stats_time_string()

fade_frames = 32
character_frames = 4;

selected_frames = 24
selected_blink_frames = 12;
selected_blinked_frames = 6;


menu_index = 0;
menu_num = 3
menu_last_step = 0
menu_hold_frames = 32

menu_item_continue = 0;
menu_item_new = 1;
menu_item_credits = 2;


continue_enabled = can_load()