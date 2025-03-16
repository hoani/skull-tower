create_sfx(snd_envy_spike_spawn, x, y)

instance_create_depth(x, y, depth -1, obj_part_shrink, {
    sprite_index: spr_envy_summon_circle,
    image_blend: C_GREEN,
    lifetime: 32,   
})
