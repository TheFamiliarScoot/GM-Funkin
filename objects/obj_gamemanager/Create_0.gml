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

var centerLeft = 300;
var centerRight = global.view_width - 300;
var centerMid = global.view_width/2;
var strum_spacing = 4 * 2;

global.strum_positions = [
	centerRight-(24*strum_spacing),
	centerRight-(8*strum_spacing),
	centerRight+(8*strum_spacing),
	centerRight+(24*strum_spacing),
	centerLeft-(24*strum_spacing),
	centerLeft-(8*strum_spacing),
	centerLeft+(8*strum_spacing),
	centerLeft+(24*strum_spacing)
];
global.mid_strum_positions = [
	centerMid-(24*strum_spacing),
	centerMid-(8*strum_spacing),
	centerMid+(8*strum_spacing),
	centerMid+(24*strum_spacing)
];

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
	new Preset("TUTORIAL", obj_bg_stage, obj_bf, obj_gf, obj_gf),
	new Preset("WEEK 1", obj_bg_stage, obj_bf, obj_gf, obj_dad),
	new Preset("WEEK 2", obj_bg_spooky, obj_bf, obj_gf, obj_spookykids),
	new Preset("WEEK 3", obj_bg_philly, obj_bf, obj_gf, obj_pico),
	new Preset("WEEK 6 - SENPAI", obj_bg_school, obj_bf_pixel, obj_gf_pixel, obj_senpai),
	new Preset("WEEK 6 - ROSES", obj_bg_school_roses, obj_bf_pixel, obj_gf_pixel, obj_senpai_angry),
	new Preset("WEEK 6 - THORNS", obj_bg_evilschool, obj_bf_pixel, obj_gf_pixel, obj_spirit)
]

global.chars = [
	new Character("BOYFRIEND", obj_bf, spr_icon_bf, spr_bf_idle),
	new Character("DADDY DEAREST", obj_dad, spr_icon_dad, spr_dad_idle),
	new Character("GIRLFRIEND", obj_gf, spr_icon_gf, spr_gf_danceleft),
	new Character("SKID & PUMP", obj_spookykids, spr_icon_spookykids, spr_spooky_danceleft),
	new Character("PICO", obj_pico, spr_icon_pico, spr_pico_idle),
	new Character("MOMMY MEAREST", obj_mom, spr_icon_mom, spr_mom_idle),
	new Character("SENPAI", obj_senpai, spr_icon_senpai, spr_senpai_idle),
	new Character("SENPAI (ANGRY)", obj_senpai_angry, spr_icon_senpai, spr_asenpai_idle),
	new Character("SPIRIT", obj_spirit, spr_icon_spirit, spr_spirit_idle),
	new Character("BOYFRIEND (PIXEL)", obj_bf_pixel, spr_icon_bf_pixel, spr_bf_pixel_idle),
	new Character("GIRLFRIEND (PIXEL)", obj_gf_pixel, spr_icon_gf, spr_gf_pixel_danceleft),
	new Character("TANKMAN", obj_tankman, spr_icon_tankman, spr_tankman_idle),
	new Character("BOYFRIEND (HOLDING GIRLFRIEND)", obj_bf_gf, spr_icon_bf, spr_bf_gf_idle),
	new Character("DARNELL", obj_darnell, spr_icon_darnell, spr_darnell_idle),
	new Character("NENE", obj_nene, spr_icon_gf, spr_nene_dance_left)
];

global.stages = [
	new Stage("THE STAGE", obj_bg_stage),
	new Stage("HAUNTED MANSION", obj_bg_spooky),
	new Stage("PHILLY", obj_bg_philly),
	new Stage("SCHOOL", obj_bg_school),
	new Stage("SCHOOL?", obj_bg_school_roses),
	new Stage("GLITCHED SCHOOL", obj_bg_evilschool),
];

var set = global.presets[global.preset];

if !opt.customization.usepreset {
	global.gfobject = global.chars[opt.customization.gfobject].object;
	global.dadobject = global.chars[opt.customization.dadobject].object;
	global.bfobject = global.chars[opt.customization.bfobject].object;
	global.bgobject = global.stages[opt.customization.bgobject].object;
}
else {
	global.gfobject = set.gf;
	global.dadobject = set.dad;
	global.bfobject = set.bf;
	global.bgobject = set.stage;
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

room_goto(room_menu);

pausesprite = -1;
uicopy = 0;
uisprite = -1;

lastcamerax = 0;
lastcameray = 0;

show_counter = true;

global.parappamode = false;

global.undertale = false;
