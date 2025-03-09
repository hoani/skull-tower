state_wait = 0
state_story0 = 1
state_story0_fade = 2
state_story1 = 3
state_story1_fade = 4
state_story2 = 5
state_credits = 6

min_story_duration = 300
max_story_duration = 450

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


fade_frames = 32
character_frames = 4;

