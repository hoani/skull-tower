event_inherited()

switch state.current {
    case H_DIE:
        if state.step >= HERO_DIE_FRAMES {
            trigger_room_reset()
        }
        break;
}

if y > room_height {
    hero_die()
}
