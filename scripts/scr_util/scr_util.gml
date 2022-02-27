// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// i kinda hate seeing warnings lol
song = 0;
notes = 0;
changeBPM = 0;
mustHitSection = 0;
sectionNotes = 0;


function c_bpmchange(b,s,t) constructor {
	bpm = b;
	step = s;
	time = t;
}

function key_to_string(k) {
	// source: http://www.davetech.co.uk/gamemakerkeyboardasciicodes
	
	var key = [];
	
	key[0] = "...";
	
	key[9] = "Tab"
	key[8] = "Backspace"
	key[160] = "Left Shift"
	key[162] = "Left Control"
	key[164] = "Left Alt"
	key[165] = "Right Alt"
	key[92] = "Right Windows Key"
	key[163] = "Right Control"
	key[161] = "Right Shift"

	key[12] = "Num 5" // This is actual Num 5 but when Numlock is off, even Wiki says it "Does Nothing"
	key[13] = "Enter"

	key[16] = "Shift"
	key[17] = "Control"
	key[18] = "Alt"
	key[19] = "Pause"
	key[20] = "Capslock"

	key[32] = "Space"
	key[33] = "Page up"
	key[34] = "Page down"
	key[35] = "End"
	key[36] = "Home"

	key[37] = "Left"
	key[38] = "Up"
	key[39] = "Right"
	key[40] = "Down"

	key[45] = "Insert"
	key[46] = "Delete"

	key[48] = "0"
	key[49] = "1"
	key[50] = "2"
	key[51] = "3"
	key[52] = "4"
	key[53] = "5"
	key[54] = "6"
	key[55] = "7"
	key[56] = "8"
	key[57] = "9"

	key[65] = "A"
	key[66] = "B"
	key[67] = "C"
	key[68] = "D"
	key[69] = "E"
	key[70] = "F"
	key[71] = "G"
	key[72] = "H"
	key[73] = "I"
	key[74] = "J"
	key[75] = "K"
	key[76] = "L"
	key[77] = "M"
	key[78] = "N"
	key[79] = "O"
	key[80] = "P"
	key[81] = "Q"
	key[82] = "R"
	key[83] = "S"
	key[84] = "T"
	key[85] = "U"
	key[86] = "V"
	key[87] = "W"
	key[88] = "X"
	key[89] = "Y"
	key[90] = "Z"
	key[91] = "Windows Key"

	key[93] = "Context Menu"

	key[96] = "Num 0"
	key[97] = "Num 1"
	key[98] = "Num 2"
	key[99] = "Num 3"
	key[100] = "Num 4"
	key[101] = "Num 5"
	key[102] = "Num 6"
	key[103] = "Num 7"
	key[104] = "Num 8"
	key[105] = "Num 9"

	key[106] = "Num *"
	key[107] = "Num +"
	key[109] = "Num -"
	key[110] = "Num ."
	key[111] = "Num /"


	key[112] = "F1"
	key[113] = "F2"
	key[114] = "F3"
	key[115] = "F4" // was left black
	key[116] = "F5" // was left black
	key[117] = "F6" // was left black
	key[118] = "F7"
	key[119] = "F8"
	key[120] = "F9" // was left black
	key[121] = "F10"
	key[122] = "F11"
	key[123] = "F12" // was left black

	key[144] = "NUMLOCK"

	key[173] = "Mute"
	key[173] = "Volume Down"
	key[173] = "Volume Up"

	key[186] = ";"
	key[187] = "="
	key[188] = ","
	key[189] = "-"
	key[190] = "."
	key[191] = "/"
	key[192] = "\""

	key[219] = "["
	key[220] = "\\"
	key[221] = "]"
	key[222] = "\#" // actually # but that needs to be escaped

	key[223] = "`" // actually ` but that needs to be escaped
	
	return key[k];
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
	show_debug_message(str)
	switch str {
		case "normal": return 0; break;
		case "hurt": return 1; break;
		case "heal": return 2; break;
		case "dodge": return 3; break;
		case "instakill": return 4; break;
		default: return -1; break;
	}
}