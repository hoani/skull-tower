// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function instance_create(_x, _y, _obj, _struct={}){
	return instance_create_layer(_x, _y, "sfx", _obj, _struct)
}

function instance_create_ui(_x, _y, _obj, _struct={}){
	return instance_create_layer(_x, _y, "ui", _obj, _struct)
}

function instance_create_hero(_x, _y, _obj, _struct={}){
    return instance_create_layer(_x, _y, "hero", _obj, _struct)
}

function instance_create_enemy(_x, _y, _obj, _struct={}){
    return instance_create_layer(_x, _y, "enemy", _obj, _struct)
}

function instance_create_obstacles(_x, _y, _obj, _struct={}){
    return instance_create_layer(_x, _y, "obstacles", _obj, _struct)
}

function instance_create_mblocks(_x, _y, _obj, _struct={}){
    return instance_create_layer(_x, _y, "moving_blocks", _obj, _struct)
}

function instance_create_sfx(_x, _y, _obj, _struct={}){
    return instance_create_layer(_x, _y, "sfx", _obj, _struct)
}
