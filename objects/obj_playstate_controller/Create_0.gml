texture_prefetch("ingame_ui");
texture_flush("mainmenu");

global.dadinstance = noone;
global.bfinstance = noone;
global.gfinstance = noone;

conductordata = load_conductor_data(global.selectedpack, global.selectedsong, global.selecteddifficulty);
conductor = create_conductor(conductordata);
call_lua("onLoad", global.selectedsong);

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

	global.dadobject = set.dad;
	global.gfobject = set.gf;
	global.bfobject = set.bf;
	global.bgobject = set.stage;
}

var object = noone;
var gfisdad = global.dadobject == global.gfobject;

if gfisdad { object = obj_gfspawn; }
else { object = obj_dadspawn; }
global.dadinstance = create_character(object.x,object.y,object.layer,0,global.dadobject,conductor);

object = obj_bfspawn;
global.bfinstance = create_character(object.x,object.y,object.layer,1,global.bfobject,conductor);

object = obj_gfspawn;
global.gfinstance = create_character(object.x,object.y,object.layer,2,global.gfobject,conductor);

if !opt.nobg { instance_create_layer(0,0,layer,global.bgobject); }
else { instance_create_layer(0,0,layer,obj_static_bg) }

global.hp = 1;
global.score = 0;
global.misses = 0;
global.combo = 0;
global.highcombo = 0;
global.accuracy = 0;
global.notesplayed = 0;
global.noteshit = 0;
global.ratings = {
	sick: 0,
	good: 0,
	bad: 0,
	shit: 0
}
global.player = opt.player1 ? global.dadinstance : global.bfinstance;
global.target = global.player;
global.paused = false;

gui_width = room_width/2;
gui_height = room_height/2
display_set_gui_size(gui_width,gui_height);

create_strums_default();

// TODO: in MP, don't start 'til synced
alarm[0] = 3;
