hp_update(hp)

if hp.current <= 0 {
    instance_destroy()
    instance_create_depth(x, y, 0, obj_boss_die, {sprite_index: spr_sloth_die})
    with(obj_sloth_inner) {
        instance_destroy()
    }
}
