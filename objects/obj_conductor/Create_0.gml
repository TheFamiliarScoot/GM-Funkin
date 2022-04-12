var diffaddstring = "";
if global.selecteddifficulty != "normal" {diffaddstring = "-" + global.selecteddifficulty}

jsonlocation = "assets\\songs\\" + global.selectedpack + "\\" + global.selectedsong.name + "\\" + global.selectedsong.name + diffaddstring + ".json";
chrt = read_json(jsonlocation);

global.keyamt = 4;

cond = {}
cond.bpm = chrt.song.bpm;
cond.crochet = ((60 / cond.bpm) * 1000);
cond.songpos = -(940*cond.crochet);
cond.notepos = -(940*cond.crochet);
cond.gbeat = 0;
cond.gstep = 0;
cond.cbeat = 0;
cond.cstep = 0;
cond.offset = -10;
cond.beathit = false;
cond.stephit = true;
cond.stepcrochet = cond.crochet/4;
cond.section = 0;
cond.sectioncount = 0;

global.camchange = [];
global.bpmchange = [];
global.sections = [];

for (var i = 0; i < array_length(chrt.song.notes) + 1; i += 1) {
	global.sections[i] = [];
	for (var h = 0; h < global.keyamt; h += 1) {
		global.sections[i][0][h] = [];
	}
	for (var j = 0; j < global.keyamt; j += 1) {
		global.sections[i][1][j] = [];
	}
}

var totalnotecount = 0;
var cursteps = 0;
var curbpm = cond.bpm;
var curpos = 0;

var donotechecks = false;

var strums = global.keyamt * 2;

cond.sectioncount = array_length(chrt.song.notes);

try {
	for (var h = 0; h < array_length(chrt.song.notes); h += 1) {
		// more code to reference here because i'm stupid
		// the way the original game checks bpm changes is by essentially simulating the song over a loop
		// we'll do it here while loading it
	
		// all engines i've looked at charts for have lengthInSteps so it should be fine
		/*
		try {
			if (chrt.song.notes[h].changeBPM && chrt.song.notes[h].bpm != curbpm) {
				curbpm = chrt.song.notes[h].bpm;
				array_push(global.bpmchange,new c_bpmchange(curbpm,cursteps,curpos));
			}
		}
		catch (e) {
			array_push(global.bpmchange,noone);
		}
		*/
	
	
		// this down here is my own though
	
		for (var i = 0; i < array_length(chrt.song.notes[h].sectionNotes); i += 1) {
			var notearray = chrt.song.notes[h].sectionNotes[i];
		
			var nspecial = 0;
		
			var skip = false;
			var ignore = false;
		
			var do_strum_ids = false;

			if global.gimmicks != -1 {
				switch global.gimmicks.special_note_type {
					case "strum_ids":
						var typeid = floor(notearray[1] / strums) - 1;
						if typeid > -1 {
							nspecial = note_special_string_id(global.gimmicks.map[typeid]);
						}
						break;
					case "psych_tags":
						if array_length(notearray) > 3 {
							if variable_struct_exists(global.gimmicks,"ignore") {
								for (var h = 0; h < array_length(global.gimmicks.ignore); h += 1) {
									if notearray[3] = global.gimmicks.ignore[h] { ignore = true; }
								}
							}
							if notearray[1] < 0 { skip = true; }
							if !skip { nspecial = note_special_string_id(variable_struct_get(global.gimmicks.map,notearray[3])); }
						}
						break;
					case "fourth_value":
						if array_length(notearray) > 3 {
							nspecial = note_special_string_id(global.gimmicks.map[notearray[3]]);
						}
						break;
				}
			}
			else {
				if array_length(notearray) > 3 {
					skip = true;
				}
				for (var j = 0; j < array_length(notearray); j += 1) {
					if !is_numeric(notearray[j]) { skip = true; }
				}
			}
			if notearray[1] < 0 { skip = true; }
		
			if skip { continue; }
		
			var pos = notearray[0];
			var typ = notearray[1];
			var len = notearray[2];
		
			if !opt.specialnotes && nspecial > 0 && !ignore { continue; }
			if ignore { nspecial = 0; }
		
			var swap = chrt.song.notes[h].mustHitSection;
		
			if len < 0 { len = 0 };	
		
			var thisNote = new c_note(pos,typ,len);
		
			thisNote.special = nspecial;
		
			var rt = typ % global.keyamt;
			var side = floor(typ / global.keyamt) % 2;

			add_note(global.sections[h][swap ? !side : side][rt],thisNote);
			totalnotecount += 1;
		}
		var dsteps = chrt.song.notes[h].lengthInSteps;
		cursteps += dsteps;
		curpos = ((60 / cond.bpm) * 1000 / 4) * cursteps;
	}
}
catch (e) {
	var msg = "Could not load the chart :(\n\nTHIS IS NOT A CRASH!\n\n"
	+ e.longMessage;
	show_message(msg);
	instance_deactivate_all(false);
	room_goto(room_menu);
	exit;
}

songlocation = "assets\\songs\\" + global.selectedpack + "\\" + global.selectedsong.name + "\\Inst.ogg";
if !file_exists(songlocation) {
	show_message("Couldn't find the instrumental! :(");
	room_goto(room_menu);
}
ins = FMODGMS_Snd_LoadSound(songlocation);
vocalslocation = "assets\\songs\\" + global.selectedpack + "\\" + global.selectedsong.name + "\\Voices.ogg";
if file_exists(vocalslocation) { voc = FMODGMS_Snd_LoadSound(vocalslocation); }
else { voc = "none" }


chi = FMODGMS_Chan_CreateChannel();
chv = FMODGMS_Chan_CreateChannel();
vocalsmuted = false;

audio_group_load(audiogroup_countdown);

/*
global.sections = array_create(array_length(chrt.song.notes),[
	array_create(global.keyamt,[]),
	array_create(global.keyamt,[])
]);
*/

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
global.realscroll = global.options.scrollspeed == 0 ? chrt.song.speed/2.5 : global.options.scrollspeed/2.5;
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
		if type < 4 { 
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

//global.target = global.camchange[0];
global.target = global.bfobject;
global.paused = false;
global.gfsection = false;
slowmode = false;
conductordisplay = false;

cursection = -1;

countingdown = true;

FMODGMS_Snd_PlaySound(ins,chi);
if file_exists(vocalslocation) { FMODGMS_Snd_PlaySound(voc,chv); }
alarm[0] = 1;


stepmode = false;

lastposition = 0;

count = -2;