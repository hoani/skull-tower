function hero_die(){
    if state.current == H_DIE {
        return
    }
    instance_create(x, y, obj_hero_die, {
        image_angle: g.dir-270, 
        image_xscale: face,
    });
    state_set(state, H_DIE);
    disable = true;
}