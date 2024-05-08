global.notes = [];
global.events = [];
global.keyamt = 4;

init_conductor(global.selectedpack, global.selectedsong, global.selecteddifficulty);

chi = fmod_system_play_sound(ins, true);
chv = [-1, -1];
if voc1 > -1 { chv1 = fmod_system_play_sound(voc1, true); }
if voc2 > -1 { chv2 = fmod_system_play_sound(voc2, true); }

audio_group_load(audiogroup_countdown);

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

// one of the only instances of this ever being used
global.realscroll = global.options.scrollspeed == 0 ? cond.scrollspeed/2.5 : global.options.scrollspeed/2.5;
global.notescroll = global.options.usedownscroll ? global.realscroll : -global.realscroll;

global.hp = 1;
//alarm[0] = 10;
audiovolume = 0;
gui_width = room_width/2;
gui_height = room_height/2
display_set_gui_size(gui_width,gui_height);
strum_spacing = 4;
lastbeat = 0;
laststep = 0;

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

global.target = global.bfobject;
global.paused = false;
slowmode = false;
conductordisplay = false;

countingdown = true;

stepmode = false;

count = -2;

targets = [ global.bfinstance, global.dadinstance, global.gfinstance ];

visualizer = instance_create_layer(0, 0, layer, obj_dsp_spectrum);