var disable = false
if instance_exists(obj_boss_controller) {
    disable = true
}
var h = instance_create_hero(x, y, obj_hero, {depth: depth, disable: disable});
h.face = face
