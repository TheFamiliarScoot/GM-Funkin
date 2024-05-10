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
else { instance_create_layer(0,0,layer,obj_static_bg) }

// one of the only instances of this ever being used
global.realscroll = global.options.scrollspeed == 0 ? cond.scrollspeed/2.5 : global.options.scrollspeed/2.5;
global.notescroll = global.options.usedownscroll ? global.realscroll : -global.realscroll;

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

global.target = global.bfobject;
global.paused = false;

gui_width = room_width/2;
gui_height = room_height/2
display_set_gui_size(gui_width,gui_height);
strum_spacing = 4;

var ctr = 0;

var strumKeys = [
	global.keys.left,
	global.keys.down,
	global.keys.up,
	global.keys.right,
	global.keys.left,
	global.keys.down,
	global.keys.up,
	global.keys.right
]

var strumKeysGp = [
	gp_shoulderlb,
	gp_shoulderl,
	gp_shoulderr,
	gp_shoulderrb,
	gp_shoulderlb,
	gp_shoulderl,
	gp_shoulderr,
	gp_shoulderrb
]

repeat 8 {
	with instance_create_layer(0,0,"UI",obj_blank) {
		type = ctr;
		thisKey = strumKeys[ctr];
		thisKeyGP = strumKeysGp[ctr];
		if floor(type / global.keyamt) % 2 {
			tiedCharacter = global.dadinstance;
			if global.options.player1 isbot = false else isbot = true; 
		}
		else { 
			tiedCharacter = global.bfinstance;
			if global.options.botplay || global.options.player1 isbot = true else isbot = false;
		}
		instance_change(obj_strum,true);
	}
	++ctr;
}
ctr = 0;

// TODO: in MP, don't start 'til synced
alarm[0] = 3;