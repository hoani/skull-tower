state_update(state)

switch state.current {
    case SPRING_LOADED:
        image_index = 0;
        break;
    case SPRING_FIRED:
        image_index = state.step / 6;
        if image_index >= 5 {
            state_set(state, SPRING_LOADED)
        }
        break;
}
