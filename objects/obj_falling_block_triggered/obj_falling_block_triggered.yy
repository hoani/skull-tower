{
  "$GMObject":"",
  "%Name":"obj_falling_block_triggered",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":2,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":8,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_falling_block_triggered",
  "overriddenProperties":[
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_floor","path":"objects/obj_floor/obj_floor.yy",},"propertyId":{"name":"yspd","path":"objects/obj_floor/obj_floor.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"0",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_falling_block","path":"objects/obj_falling_block/obj_falling_block.yy",},"propertyId":{"name":"yaccel","path":"objects/obj_falling_block/obj_falling_block.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"0.125",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_falling_block","path":"objects/obj_falling_block/obj_falling_block.yy",},"propertyId":{"name":"term","path":"objects/obj_falling_block/obj_falling_block.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"4",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_moving_block_stackable","path":"objects/obj_moving_block_stackable/obj_moving_block_stackable.yy",},"propertyId":{"name":"disable","path":"objects/obj_moving_block_stackable/obj_moving_block_stackable.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"true",},
  ],
  "parent":{
    "name":"obstacle",
    "path":"folders/Objects/obstacle.yy",
  },
  "parentObjectId":{
    "name":"obj_falling_block",
    "path":"objects/obj_falling_block/obj_falling_block.yy",
  },
  "persistent":false,
  "physicsAngularDamping":0.1,
  "physicsDensity":0.5,
  "physicsFriction":0.2,
  "physicsGroup":1,
  "physicsKinematic":false,
  "physicsLinearDamping":0.1,
  "physicsObject":false,
  "physicsRestitution":0.1,
  "physicsSensor":false,
  "physicsShape":1,
  "physicsShapePoints":[],
  "physicsStartAwake":true,
  "properties":[
    {"$GMObjectProperty":"v1","%Name":"countdown","filters":[],"listItems":[],"multiselect":false,"name":"countdown","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"30","varType":0,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":true,
  "spriteId":{
    "name":"spr_falling_block",
    "path":"sprites/spr_falling_block/spr_falling_block.yy",
  },
  "spriteMaskId":null,
  "visible":true,
}