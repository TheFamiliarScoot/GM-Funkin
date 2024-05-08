#macro cond global.conductor
#macro mus global.music
#macro ins global.inst
#macro voc global.vocals
#macro voc1 global.vocals[0]
#macro voc2 global.vocals[1]
#macro chi global.inst_index
#macro chv global.vocals_index
#macro chv1 global.vocals_index[0]
#macro chv2 global.vocals_index[1]
#macro opt global.options
#macro keybind global.keys
#macro buttonbind global.buttons

#macro intfps = 120

#macro debug true

global.view_width = 1280;
global.view_height = 720;

global.windowscales = [0.75,1,1.25];

global.window_scale = global.windowscales[1];

global.gamedir = environment_get_variable("LOCALAPPDATA") + "\\GM_Funkin";

game_set_speed(120, gamespeed_fps);
delta_init();

if !debug {
	exception_unhandled_handler(function(ex) {
		randomize();
		var file = global.gamedir + "\\crash.txt";
		var random_text = [
			"i forgor ☠",
			"shit happens",
			"actually how?",
			"bruh moment",
			"skill issue",
			"honestly deserved",
			"#RIPBOZO"
		]
		if file_exists(file) file_delete(file);
		var _f = file_text_open_write(file);
		file_text_write_string(_f, ex.longMessage);
		file_text_close(_f);
	
		var funnymessage = random_text[irandom_range(0,array_length(random_text) - 1)];
		var message_text = "Game broke - " + funnymessage +
		"\nError log: \n\n" + ex.longMessage +
		"\nCrash log saved to " + file +
		"\nPlease send this file in the #gmfunkin channel!!! TY!!! - Scoot";
		
		show_message(message_text);
	});
}

global.fmod_system = fmod_system_create();
fmod_system_init(1024, FMOD_INIT.NORMAL);

//lua_error_handler = scr_lua_error;W

texture_prefetch("Default");
audio_group_load(audiogroup_default);

global.songs = [
	"tutorial",
	"bopeebo",
	"fresh",
	"dadbattle",
	"spookeez",
	"south",
	"pico",
	"philly",
	"blammed",
	"satin-panties",
	"high",
	"milf",
	"cocoa",
	"eggnog",
	"winter-horrorland",
	"senpai",
	"roses",
	"thorns",
	"ugh",
	"guns",
	"stress"
];

var tempoptions = {
	scrollspeed: 0,
	inputleniency: 150,
	usedownscroll: false,
	ghosttapping: true,
	missnotes: true,
	antialiasing: true,
	blueballing: true,
	retrykey: true,
	botplay: false,
	player1: false,
	specialcolors: false,
	middlescroll: false,
	nobg: false,
	timedisplay: false,
	specialnotes: true,
	usenoteskin: false,
	noteskin: 0,
	hpmult: 1,
	hpgainmult: 1,
	snoteinstakill: false,
	bump: true,
	notetypes: [
		1,
		2,
		3,
		-1,
		-1
	],
	customization: {
		usepreset: true,
		preset: 0,
		bfobject: 0,
		dadobject: 1,
		gfobject: 2,
		bgobject: 0
	},
	notecolors: {
		left: [192,74,152],
		down: [29,251,252],
		up: [17,246,4],
		right: [246,56,62]
	},
	build: 6
}

var file = working_directory + "keybinds.ini";
if !file_exists(file) {
	ini_open(file);
	ini_write_real("Keys","Up",ord("W"));
	ini_write_real("Keys","Down",ord("S"));
	ini_write_real("Keys","Left",ord("A"));
	ini_write_real("Keys","Right",ord("D"));
	ini_write_real("Buttons","Up",gp_shoulderr);
	ini_write_real("Buttons","Down",gp_shoulderl);
	ini_write_real("Buttons","Left",gp_shoulderlb);
	ini_write_real("Buttons","Right",gp_shoulderrb);
}
else {
	ini_open(file);
}

global.keys = {up: ord("W"), down: ord("S"), left: ord("A"), right: ord("D")}
global.keys.up = ini_read_real("Keys","Up",ord("W"));
global.keys.down = ini_read_real("Keys","Down",ord("S"));
global.keys.left = ini_read_real("Keys","Left",ord("A"));
global.keys.right = ini_read_real("Keys","Right",ord("D"));

global.buttons = {up: gp_shoulderr, down: gp_shoulderl, left: gp_shoulderlb, right: gp_shoulderrb};
global.buttons.up =	ini_read_real("Buttons","Up",gp_shoulderr);
global.buttons.down = ini_read_real("Buttons","Down",gp_shoulderl);
global.buttons.left = ini_read_real("Buttons","Left",gp_shoulderlb);
global.buttons.right = ini_read_real("Buttons","Right",gp_shoulderrb);

ini_close();


global.misses = 0;
global.hp = 1;
global.maxhp = 2;
global.combo = 0;
global.highcombo = 0;
global.ratings = {
	shit: 0,
	bad: 0,
	good: 0,
	sick: 0
}
global.notesplayed = 0;
global.noteshit = 0;
global.accuracy = -1;

global.paused = false;

global.usepresetsetup = false;
global.preset = "tutorial";

global.notetypes = [
	0,
	1,
	2,
	3
];

var dir = global.gamedir + "\\options.json";
if file_exists(dir) { 
	opt = read_json(dir);
	var names = variable_struct_get_names(tempoptions)
	for (var i = 0; i < array_length(names); i += 1) {
		if is_undefined(variable_struct_get(opt,names[i])) {
			variable_struct_set(opt,names[i],variable_struct_get(tempoptions,names[i]));
		}
	}
	write_save(working_directory + "options.json");
}
else { make_save(dir,tempoptions); }

global.colors = [
	make_color_rgb(opt.notecolors.left[0],opt.notecolors.left[1],opt.notecolors.left[2]),
	make_color_rgb(opt.notecolors.down[0],opt.notecolors.down[1],opt.notecolors.down[2]),
	make_color_rgb(opt.notecolors.up[0],opt.notecolors.up[1],opt.notecolors.up[2]),
	make_color_rgb(opt.notecolors.right[0],opt.notecolors.right[1],opt.notecolors.right[2])
];

global.ntype = [
	[],
	[{ang: 0, color: global.colors[2], anim: 2}],
	[{ang: 90, color: global.colors[0], anim: 0}, {ang: -90, color: global.colors[3], anim: 3}],
	[
		{ang: 90, color: global.colors[0], anim: 0},
		{ang: 0, color: global.colors[2], anim: 2},
		{ang: -90, color: global.colors[3], anim: 3}
	],
	[
		{ang: 90, color: global.colors[0], anim: 0},
		{ang: 180, color: global.colors[1], anim: 1},
		{ang: 0, color: global.colors[2], anim: 2},
		{ang: -90, color: global.colors[3], anim: 3}
	],
	[
		{ang: 90, color: global.colors[0], anim: 0},
		{ang: 180, color: global.colors[1], anim: 1},
		{ang: 0, color: global.colors[2], anim: 2},
		{ang: 0, color: global.colors[2], anim: 2},
		{ang: -90, color: global.colors[3], anim: 3}
	],
	[
		{ang: 90, color: global.colors[0], anim: 0},
		{ang: 180, color: global.colors[1], anim: 1},
		{ang: -90, color: global.colors[3], anim: 3},
		{ang: 0, color: global.colors[0], anim: 0},
		{ang: 90, color: global.colors[2], anim: 2},
		{ang: -90, color: global.colors[3], anim: 3}
	]
];

// update save file

global.usepresetsetup = opt.customization.usepreset;
global.preset = opt.customization.preset;

global.pixelui = false;

global.presets = [ 
	[obj_gf,obj_gf,obj_bf,obj_bg_stage], // tutorial
	[obj_dad,obj_gf,obj_bf,obj_bg_stage], // week 1
	[obj_spookykids,obj_gf,obj_bf,obj_bg_spooky], // week 2
	[obj_senpai,obj_gf_pixel,obj_bf_pixel,obj_bg_school], // week 6 senpai
	[obj_senpai_angry,obj_gf_pixel,obj_bf_pixel,obj_bg_school_roses], // week 6 roses
	[obj_spirit,obj_gf_pixel,obj_bf_pixel,obj_bg_evilschool], // week 6 thorns
]

global.chars = [
	obj_bf,
	obj_dad,
	obj_gf,
	obj_spookykids,
	obj_senpai,
	obj_senpai_angry,
	obj_spirit,
	obj_bf_pixel,
	obj_gf_pixel,
	obj_custom_char
];

global.stages = [
	obj_bg_stage,
	obj_bg_spooky,
	obj_bg_philly,
	obj_bg_school,
	obj_bg_school_roses,
	obj_bg_evilschool,
];

var set = global.presets[global.preset];

if !opt.customization.usepreset {
	global.gfobject = global.chars[opt.customization.gfobject];
	global.dadobject = global.chars[opt.customization.dadobject];
	global.bfobject = global.chars[opt.customization.bfobject];
	global.bgobject = global.stages[opt.customization.bgobject];
}
else {
	global.gfobject = set[0];
	global.dadobject = set[1];
	global.bfobject = set[2];
	global.bgobject = set[3];
}

global.bfcustom = "bf";
global.dadcustom = "hypno2";

global.noteskins = get_folders("assets/sprites/noteskins","skinoptions.json");
global.customchars = get_folders("assets/sprites/chars","object.json");
global.ignoredtags = read_text("assets/etc/ignored-tags.txt");
if array_length(global.noteskins) = 0 {
	global.noteskins = ["???"];
}
else if opt.noteskin > array_length(global.noteskins) - 1 { opt.noteskin = 0; }

global.curnoteskin = global.noteskins[opt.noteskin];

global.gimmicks = -1;

room_goto(room_menu);

pausesprite = -1;
uicopy = 0;
uisprite = -1;

lastcamerax = 0;
lastcameray = 0;

show_counter = true;

global.parappamode = false;

global.undertale = false;
