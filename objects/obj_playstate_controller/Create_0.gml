texture_prefetch("ingame_ui");
texture_flush("mainmenu");
audio_group_load(audiogroup_countdown);

global.dadinstance = noone;
global.bfinstance = noone;
global.gfinstance = noone;

conductordata = load_conductor_data(global.selectedpack, global.selectedsong, global.selecteddifficulty);
conductor = create_conductor(conductordata, 0, 0, layer);
var c = conductor;

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
if global.dadobject == global.gfobject { object = obj_gfspawn; }
else { object = obj_dadspawn; }
global.dadinstance = create_character(conductor,object.x,object.y,object.layer,0,global.dadobject);

object = obj_bfspawn;
global.bfinstance = create_character(conductor,object.x,object.y,object.layer,1,global.bfobject);

object = obj_gfspawn;
global.gfinstance = create_character(conductor,object.x,object.y,object.layer,2,global.gfobject);

if !opt.nobg { instance_create_layer(0,0,layer,global.bgobject,{conductor: c}); }
else { instance_create_layer(0,0,layer,obj_static_bg) }

// one of the only instances of this ever being used
global.realscroll = global.options.scrollspeed == 0 ? conductor.scrollspeed/2.5 : global.options.scrollspeed/2.5;
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
global.player = opt.player1 ? global.dadinstance : global.bfinstance;
global.paused = false;

gui_width = room_width/2;
gui_height = room_height/2
display_set_gui_size(gui_width,gui_height);

create_strums_default(conductor);

ui = instance_create_layer(0, 0, layer, obj_ingame_ui, {conductor: c});
camera = instance_create_layer(0, 0, layer, obj_camera, {target: global.player});

call_lua("onLoad", global.selectedsong);

// TODO: in MP, don't start 'til synced
alarm[0] = 3;
