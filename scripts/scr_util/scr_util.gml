// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


// source: http://www.davetech.co.uk/gamemakerkeyboardasciicodes
global.keymap = [];
	
global.keymap[0] = "...";
	
global.keymap[9] = "Tab"
global.keymap[8] = "Backspace"
global.keymap[160] = "Left Shift"
global.keymap[162] = "Left Control"
global.keymap[164] = "Left Alt"
global.keymap[165] = "Right Alt"
global.keymap[92] = "Right Windows Key"
global.keymap[163] = "Right Control"
global.keymap[161] = "Right Shift"

global.keymap[12] = "Num 5" // This is actual Num 5 but when Numlock is off, even Wiki says it "Does Nothing"
global.keymap[13] = "Enter"

global.keymap[16] = "Shift"
global.keymap[17] = "Control"
global.keymap[18] = "Alt"
global.keymap[19] = "Pause"
global.keymap[20] = "Capslock"

global.keymap[32] = "Space"
global.keymap[33] = "Page up"
global.keymap[34] = "Page down"
global.keymap[35] = "End"
global.keymap[36] = "Home"

global.keymap[37] = "Left"
global.keymap[38] = "Up"
global.keymap[39] = "Right"
global.keymap[40] = "Down"

global.keymap[45] = "Insert"
global.keymap[46] = "Delete"

global.keymap[48] = "0"
global.keymap[49] = "1"
global.keymap[50] = "2"
global.keymap[51] = "3"
global.keymap[52] = "4"
global.keymap[53] = "5"
global.keymap[54] = "6"
global.keymap[55] = "7"
global.keymap[56] = "8"
global.keymap[57] = "9"

global.keymap[65] = "A"
global.keymap[66] = "B"
global.keymap[67] = "C"
global.keymap[68] = "D"
global.keymap[69] = "E"
global.keymap[70] = "F"
global.keymap[71] = "G"
global.keymap[72] = "H"
global.keymap[73] = "I"
global.keymap[74] = "J"
global.keymap[75] = "K"
global.keymap[76] = "L"
global.keymap[77] = "M"
global.keymap[78] = "N"
global.keymap[79] = "O"
global.keymap[80] = "P"
global.keymap[81] = "Q"
global.keymap[82] = "R"
global.keymap[83] = "S"
global.keymap[84] = "T"
global.keymap[85] = "U"
global.keymap[86] = "V"
global.keymap[87] = "W"
global.keymap[88] = "X"
global.keymap[89] = "Y"
global.keymap[90] = "Z"
global.keymap[91] = "Windows Key"

global.keymap[93] = "Context Menu"

global.keymap[96] = "Num 0"
global.keymap[97] = "Num 1"
global.keymap[98] = "Num 2"
global.keymap[99] = "Num 3"
global.keymap[100] = "Num 4"
global.keymap[101] = "Num 5"
global.keymap[102] = "Num 6"
global.keymap[103] = "Num 7"
global.keymap[104] = "Num 8"
global.keymap[105] = "Num 9"

global.keymap[106] = "Num *"
global.keymap[107] = "Num +"
global.keymap[109] = "Num -"
global.keymap[110] = "Num ."
global.keymap[111] = "Num /"


global.keymap[112] = "F1"
global.keymap[113] = "F2"
global.keymap[114] = "F3"
global.keymap[115] = "F4" // was left black
global.keymap[116] = "F5" // was left black
global.keymap[117] = "F6" // was left black
global.keymap[118] = "F7"
global.keymap[119] = "F8"
global.keymap[120] = "F9" // was left black
global.keymap[121] = "F10"
global.keymap[122] = "F11"
global.keymap[123] = "F12" // was left black

global.keymap[144] = "NUMLOCK"

global.keymap[173] = "Mute"
global.keymap[173] = "Volume Down"
global.keymap[173] = "Volume Up"

global.keymap[186] = ";"
global.keymap[187] = "="
global.keymap[188] = ","
global.keymap[189] = "-"
global.keymap[190] = "."
global.keymap[191] = "/"
global.keymap[192] = "\""

global.keymap[219] = "["
global.keymap[220] = "\\"
global.keymap[221] = "]"
global.keymap[222] = "\#" // actually # but that needs to be escaped

global.keymap[223] = "`" // actually ` but that needs to be escaped

function key_to_string(k) {	
	return global.keymap[k];
}

function bool_onoff(b) { return b ? "ON" : "OFF"; }
function bool_yesno(b) { return b ? "YES" : "NO"; }

function specialnote_to_string(t) {
	var typenames = [
		"NORMAL",
		"HURT NOTE",
		"HEAL NOTE",
		"DODGE NOTE"
	];
	if t < 0 { return "DISABLED"; }
	else { return string_upper(typenames[t]); }
}

function var_exists(v) {
	try { show_debug_message(v);}
	catch (lol) { return false; }
	return true;
}

function make_save(dir,temp) {
	if file_exists(dir) { file_delete(dir); }
	var optionsfile = file_text_open_write(dir);
	file_text_write_string(optionsfile,json_stringify(temp));
	file_text_close(optionsfile);
	opt = temp;	
}

function write_save(optfile) {
	if file_exists(optfile) { file_delete(optfile) }
	var wrfile = file_text_open_write(optfile);
	file_text_write_string(wrfile,json_stringify(opt));
	file_text_close(wrfile);	
}

function get_from_path(struct,path) {
	var patharray = string_split(path,".");
	
	var finalval = 0;
	
	for (var i = 0; i < array_length(patharray); i += 1) {
		finalval = variable_struct_get(struct,patharray[i]);
	}
	
	return finalval;
}

function set_from_path(struct,path,val) {
	var patharray = string_split(path,".");
	
	var finalval = 0;
	
	for (var i = 0; i < array_length(patharray); i += 1) {
		finalval = variable_struct_get(struct,patharray[i]);
	}
	
	finalval = val;
}

function write_score(song,diff,scr,combo,misses,rating,acc) {
	var file = "scores.dat";
	var scorelist = ds_map_secure_load(file);
	if scorelist = -1 {
		var templist = ds_map_create();
		ds_map_secure_save(templist,file);
		ds_map_destroy(templist);
		scorelist = ds_map_secure_load(file);
	}

	var key = song + "-" + diff;
	if !ds_map_exists(scorelist,key) {
		ds_map_add(scorelist,key,json_stringify({
			bestscore: scr,
			bestcombo: combo,
			leastmisses: misses,
			ratings: rating,
			highestaccuracy: acc
		}));
	}
	else {
		var map = json_parse(scorelist[? key]);
		if map.bestscore < scr { map.bestscore = scr; }
		if map.bestcombo < combo { map.bestcombo = combo; }
		if map.leastmisses > misses { map.leastmisses = misses; }
		if map.ratings.sick < rating.sick { map.ratings.sick = rating.sick; }
		if map.ratings.good < rating.good { map.ratings.good = rating.good; }
		if map.ratings.bad < rating.bad { map.ratings.bad = rating.bad; }
		if map.ratings.shit < rating.shit { map.ratings.shit = rating.shit; }
		if map.highestaccuracy < acc { map.highestaccuracy = acc; }
		scorelist[? key] = json_stringify(map);
	}
	
	ds_map_secure_save(scorelist,file);
	ds_map_destroy(scorelist);
}

function randomize_string(str,seed) {
	random_set_seed(seed);
	var newstr = str;
	for (var i = 1; i < string_length(newstr); i += 1) {
		var char = ord(string_char_at(newstr,i));
		char += irandom_range(-3,3);
		string_delete(newstr,i,1);
		string_insert(chr(char),newstr,i);
	}
	return newstr;
}

function unrandomize_string(str,seed) {
	random_set_seed(seed);
	var newstr = str;
	for (var i = 1; i < string_length(newstr); i += 1) {
		var char = ord(string_char_at(newstr,i));
		char -= irandom_range(-3,3);
		string_delete(newstr,i,1);
		string_insert(chr(char),newstr,i);
	}
	return newstr;
}

function input_check(kb, gp = -1) {
	if keyboard_check(kb) || gamepad_button_check(0, gp) { return true; }
	else { return false; }
}

function input_check_pressed(kb, gp = -1) {
	if keyboard_check_pressed(kb) || gamepad_button_check_pressed(0, gp) { return true; }
	else { return false; }
}

function input_check_released(kb, gp = -1) {
	if keyboard_check_released(kb) || gamepad_button_check_released(0, gp) { return true; }
	else { return false; }
}

function check_controller_buttons() {
	var buttons = [
		gp_face1,
		gp_face2,
		gp_face3,
		gp_face4,
		gp_shoulderl,
		gp_shoulderlb,
		gp_shoulderr,
		gp_shoulderrb,
		gp_stickl,
		gp_stickr,
		gp_padu,
		gp_padd,
		gp_padl,
		gp_padr
	];
	
	for (var i = 0; i < array_length(buttons); i += 1) {
		if gamepad_button_check_pressed(0, buttons[i]) { return buttons[i]; }
	}
	return -1;
}

function button_to_string(but) {
	switch but {
		case 0: return "...";
		case gp_face1: return "FACE BUTTON 1";
		case gp_face2: return "FACE BUTTON 2";
		case gp_face3: return "FACE BUTTON 3";
		case gp_face4: return "FACE BUTTON 4";
		case gp_shoulderl: return "LEFT SHOULDER";
		case gp_shoulderr: return "RIGHT SHOULDER";
		case gp_shoulderlb: return "LEFT TRIGGER";
		case gp_shoulderrb: return "RIGHT TRIGGER";
		case gp_stickl: return "L3";
		case gp_stickr: return "R3";
		case gp_padu: return "DPAD UP";
		case gp_padd: return "DPAD DOWN";
		case gp_padl: return "DPAD LEFT";
		case gp_padr: return "DPAD RIGHT";
		default: return "?";
	}
}

function get_score(key) {
	if !ds_exists(global.stats, ds_type_map) {
		global.stats = try_load_scores("scores.dat")
	}
	return global.stats[? key];
}

function note_special_string_id(str) {
	switch str {
		case "normal": return 0;
		case "hurt": return 1;
		case "heal": return 2;
		case "dodge": return 3;
		case "instakill": return 4;
		default: return -1;
	}
}

function load_textures(texture) {
	texturegroup_load(texture);
}