state_title = 0
state_fade = 1
state_story0 = 2
state_story1 = 3
state_story2 = 4
state_story2_fade = 5
state_idle = 6

story_duration = 240

state = new_state(state_title)

story_text = [
    "   Skeletrex has\n   been defeated\nand humanity knows\n  peace once again.",
    "   However, the\nseven bone generals\n  are plotting to\n revive Skeletrex.",
    "   Damn bonies!\nHumanity needs a\n  true warrior to\n    defeat the\n  bone generals!",
];

story_index = 0;
text_index = 0;

award = stats_award()

time = stats_time_string()




