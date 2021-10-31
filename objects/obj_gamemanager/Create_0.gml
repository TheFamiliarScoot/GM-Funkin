#macro cond global.conductor
#macro chrt global.chart
#macro chi global.channel_i
#macro chv global.channel_v
#macro voc global.vocals
#macro ins global.inst
#macro opt global.options
#macro keybind global.keys

#macro intfps = 120;

global.view_width = 1280;
global.view_height = 720;

global.windowscales = [0.75,1,1.25];

global.window_scale = global.windowscales[1];

global.gamedir = environment_get_variable("LOCALAPPDATA") + "\\GM_Funkin";

room_speed = 120;
delta_init();

exception_unhandled_handler(function(ex) {
	randomize();
	var file = global.gamedir + "\\crash.txt";
	var random_text = [
		"i forgor ☠",
		"shit happens",
		"actually how?",
		"bruh moment",
		"skill issue",
		"honestly deserved"
	]
	if file_exists(file) file_delete(file);
	var _f = file_text_open_write(file);
	file_text_write_string(_f, ex.longMessage);
	file_text_close(_f);
	
	var funnymessage = random_text[irandom_range(0,array_length(random_text) - 1)];
	var message_text = "Game broke - " + funnymessage + "\n" +
	"Error log: \n\n" + ex.longMessage + "\n" +
	"Crash log saved to " + file +
	"\nPlease send this file in the #gmfunkin channel!!! TY!!! - Scoot";
		
	show_message(message_text);
});

// Create the system
FMODGMS_Sys_Create();
// Initialize the system
FMODGMS_Sys_Initialize(32);

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
	build: 4
}


global.misses = 0;
global.hp = 1;
global.maxhp = 2;

global.paused = false;

global.usepresetsetup = false;
global.preset = "tutorial";

var dir = global.gamedir + "\\options.json";
if file_exists(dir) { 
	opt = read_json(dir);
	try { if opt.build != tempoptions.build { make_save(dir,tempoptions); } }
	catch (sussy) { make_save(dir,tempoptions); }
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
	obj_gf_pixel
];

global.stages = [
	obj_bg_stage,
	obj_bg_spooky,
	obj_bg_school,
	obj_bg_school_roses,
	obj_bg_evilschool
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

room_goto(room_menu);

pausesprite = -1;
uicopy = 0;
uisprite = -1;

lastcamerax = 0;
lastcameray = 0;