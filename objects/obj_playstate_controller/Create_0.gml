texture_prefetch("ingame_ui");
texture_flush("mainmenu");

global.dadinstance = noone;
global.bfinstance = noone;
global.gfinstance = noone;


if opt.usenoteskin {
	var ndir = "assets/sprites/noteskins/" + global.curnoteskin + "/";
	global.noteopt = read_json(ndir + "skinoptions.json");
	var nopt = global.noteopt;
	global.noteskin = sprite_add(ndir + "note.png",3,false,false,nopt.size_note[0]/2,nopt.size_note[1]/2);
	global.noteskin_o = sprite_add(ndir + "note_overlay.png",3,false,false,nopt.size_note[0]/2,nopt.size_note[1]/2);
	global.noteskin_tail = sprite_add(ndir + "tail.png",2,false,false,nopt.size_tail[0]/2,0);
	global.noteskin_tailo = sprite_add(ndir + "tail_overlay.png",2,false,false,nopt.size_tail[0]/2,0);
}

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
if global.dadobject = obj_custom_char { global.dadinstance = create_custom_char(global.dadcustom,object.x,object.y,object.layer,0); }
else { global.dadinstance = spawn_char(object.x,object.y,object.layer,0,global.dadobject); }

object = obj_bfspawn
if global.bfobject = obj_custom_char { global.bfinstance = create_custom_char(global.bfcustom,object.x,object.y,object.layer,1); }
else { global.bfinstance = spawn_char(object.x,object.y,object.layer,1,global.bfobject); }

object = obj_gfspawn
if !gfisdad { global.gfinstance = spawn_char(object.x,object.y,object.layer,2,global.gfobject); }

if !opt.nobg { instance_create_layer(0,0,layer,global.bgobject); }