instance_destroy()
block = instance_create_depth(x, y, depth, obj_breakable_block, {
    xspd: xspd, 
    yspd: yspd, 
    xaccel: xaccel, 
    yaccel: yaccel,
    term: term,
    image_xscale: image_xscale,
    image_yscale: image_yscale,
    collision_obj: collision_obj,
    sprite_index: summoned_spr,
    c_broken: c_broken,
})

with (obj_spike_spawn) {
    if other.id == attached {
        attached = other.block
    }
}

with (obj_spikes) {
    if other.id == attached {
        attached = other.block
    }
}
