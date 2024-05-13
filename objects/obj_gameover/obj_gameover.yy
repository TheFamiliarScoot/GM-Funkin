{
  "$GMObject":"",
  "%Name":"obj_gameover",
  "eventList":[
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":7,"eventType":7,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":64,"eventType":8,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":1,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":12,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":2,"eventType":2,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":8,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_gameover",
  "overriddenProperties":[],
  "parent":{
    "name":"playstate",
    "path":"folders/Objects/game/playstate.yy",
  },
  "parentObjectId":null,
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
    {"$GMObjectProperty":"v1","%Name":"camOffX","filters":[],"listItems":[],"multiselect":false,"name":"camOffX","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"camOffY","filters":[],"listItems":[],"multiselect":false,"name":"camOffY","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"-200","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"music","filters":[],"listItems":[],"multiselect":false,"name":"music","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"assets/music/gameOver.ogg","varType":2,},
    {"$GMObjectProperty":"v1","%Name":"music_end","filters":[],"listItems":[],"multiselect":false,"name":"music_end","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"assets/music/gameOverEnd.ogg","varType":2,},
    {"$GMObjectProperty":"v1","%Name":"die_sprite","filters":[],"listItems":[],"multiselect":false,"name":"die_sprite","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resource":{"name":"spr_bf_die","path":"sprites/spr_bf_die/spr_bf_die.yy",},"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"spr_bf_die","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"die_loop_sprite","filters":[],"listItems":[],"multiselect":false,"name":"die_loop_sprite","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resource":{"name":"spr_bf_die_loop","path":"sprites/spr_bf_die_loop/spr_bf_die_loop.yy",},"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"spr_bf_die_loop","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"die_retry_sprite","filters":[],"listItems":[],"multiselect":false,"name":"die_retry_sprite","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resource":{"name":"spr_bf_die_retry","path":"sprites/spr_bf_die_retry/spr_bf_die_retry.yy",},"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"spr_bf_die_retry","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"music_start_frame","filters":[],"listItems":[],"multiselect":false,"name":"music_start_frame","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"250","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"die_sound","filters":[],"listItems":[],"multiselect":false,"name":"die_sound","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resource":{"name":"snd_death","path":"sounds/snd_death/snd_death.yy",},"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"snd_death","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"scale","filters":[],"listItems":[],"multiselect":false,"name":"scale","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"no_antialiasing","filters":[],"listItems":[],"multiselect":false,"name":"no_antialiasing","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":3,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":{
    "name":"spr_bf_die",
    "path":"sprites/spr_bf_die/spr_bf_die.yy",
  },
  "spriteMaskId":null,
  "visible":true,
}