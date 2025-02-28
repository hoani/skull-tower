event_inherited()

switch state.current {
    case H_DIE:
        if state.step >= HERO_DIE_FRAMES {
            room_restart();
            // Increase death count.
        }
        break;
        
}
