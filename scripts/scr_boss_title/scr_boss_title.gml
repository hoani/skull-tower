

function spawn_title_sloth() {
    spawn_intro(spr_sloth_title)
}

function spawn_title_gluttony() {
    spawn_intro(spr_gluttony_title)
}

function spawn_title_envy() {
    spawn_intro(spr_envy_title)
}

function spawn_title_lust() {
    spawn_intro(spr_lust_title)
}

function spawn_title_greed() {
    spawn_intro(spr_greed_title)
}

function spawn_title_wrath() {
    spawn_intro(spr_wrath_title)
}

function spawn_title_pride() {
    spawn_intro(spr_pride_title)
}



function spawn_intro(_which) {
    instance_create_ui(room_width/2, room_height/2-32, obj_boss_title, {sprite_index: _which})
}
