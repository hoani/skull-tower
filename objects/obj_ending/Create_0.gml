state_wait = 0
state_story0 = 1
state_story1 = 2
state_story2 = 3
state_credits = 4

story_duration = 240

state = new_state(state_wait)

story_text = [
    "The bone generals\n  were defeated.",
    "Humanity is safe\n from the threat\n  of Skeletrex.",
    "        You are\ntruely humanity's",
];

story_index = 0;
text_index = 0;

award = stats_award()

time = stats_time_string()




