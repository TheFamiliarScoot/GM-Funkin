texture_prefetch("ingame_ui");
texture_flush("mainmenu");


if opt.customization.usepreset {
	var set = global.presets[opt.customization.preset];

	global.dadobject = set[0];
	global.gfobject = set[1];
	global.bfobject = set[2];
	global.bgobject = set[3];
}

var object = noone;
var gfisdad = global.dadobject == global.gfobject;

if gfisdad { object = obj_gfspawn; }
else { object = obj_dadspawn; }
instance_create_layer(object.x,object.y,object.layer,global.dadobject);

object = obj_bfspawn
instance_create_layer(object.x,object.y,object.layer,global.bfobject);

object = obj_gfspawn
if !gfisdad { instance_create_layer(object.x,object.y,object.layer,global.gfobject); }

if !opt.nobg { instance_create_layer(0,0,layer,global.bgobject); }