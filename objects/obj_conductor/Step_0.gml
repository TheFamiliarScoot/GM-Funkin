if voc != "none" { FMODGMS_Chan_Set_Volume(chv,!vocalsmuted*audiovolume); }
FMODGMS_Chan_Set_Volume(chi,audiovolume);
var samprate = (FMODGMS_Chan_Get_Frequency(chi) * 0.001);

var pos = ((FMODGMS_Chan_Get_Position(chi) / samprate) / 4) + cond.offset;
var npos = (FMODGMS_Chan_Get_Position(chi) / samprate) + cond.offset;

if countingdown {
	cond.section = 0;
	cond.songpos = pos - cond.crochet;
	cond.notepos = npos - (cond.crochet * 4);
}
else {
	cond.songpos = pos;
	cond.notepos = npos;
}
if cond.songpos >= 0 && countingdown {
	countingdown = false;
	FMODGMS_Chan_Set_Position(chi,0);
	FMODGMS_Chan_Set_Position(chv,0);
	audiovolume = 0.5;
}
cond.gstep = cond.songpos / cond.stepcrochet;
cond.gbeat = cond.gstep / 4;
cond.cbeat = floor(cond.gbeat);
cond.cstep = floor(cond.gstep) % 4;
if !countingdown {
	cond.section = clamp(cond.cbeat,0,cond.sectioncount - 1);
}

var cursection = {};
try {
	cursection = chrt.song.notes[clamp(
		floor(cond.gstep / 4),	0,
		array_length(chrt.song.notes)
		)
	];
}
catch (a) { 
	cursection = {
		mustHitSection: false	
	}
}

/*
var lastbpmchange = new c_bpmchange(0,0,0);

for (var i = 0; i < array_length(global.bpmchange); i += 1) {
	if global.bpmchange[i] != noone {
		if cond.songpos >= global.bpmchange[i].time { 
			lastbpmchange = global.bpmchange[i];
			show_debug_message("bpm change");
		}
	}
}

var bpctime = ((lastbpmchange.time / samprate) / 4);

cond.cstep = lastbpmchange.step + floor((cond.songpos - bpctime) / cond.stepcrochet);


try {
	if cursection.changeBPM {
		cond.bpm = cursection.bpm;
		cond.crochet = ((60 / cond.bpm) * 1000);
		cond.stepcrochet = cond.crochet/4;
	}
}
catch (e3) {
	
}
*/
try {
	if cursection.mustHitSection { global.target = global.bfinstance; }
	else { global.target = global.dadinstance; }
}
catch (wtf) {}

if cond.beathit {
	if conductordisplay { audio_play_sound(sfx_beat,0,false); }
}
else if cond.stephit && conductordisplay { audio_play_sound(sfx_bar,0,false); }

if !stepmode && !global.paused {
	if !window_has_focus() {
		FMODGMS_Chan_PauseChannel(ins);
		FMODGMS_Chan_PauseChannel(voc);
	}
	else {
		FMODGMS_Chan_ResumeChannel(ins);
		FMODGMS_Chan_ResumeChannel(voc);
	}
}

if FMODGMS_Chan_Get_Position(chi) >= FMODGMS_Snd_Get_Length(ins) {
	room_transition(room_menu);
}

var c = floor(pos / cond.stepcrochet);
if countingdown && c != count {
	switch c {
		case 0: audio_play_sound(snd_cd_three,3,false); break;
		case 1: audio_play_sound(snd_cd_two,2,false); break;
		case 2: audio_play_sound(snd_cd_one,1,false); break;
		case 3: audio_play_sound(snd_cd_go,0,false); break;
	}
	if !(c < 1) {
		with instance_create_layer(global.view_width/2,global.view_height/2,"UI",obj_blank) {
			countspr = c;
			instance_change(obj_countdown,true);
		}
	}
}
count = c;

cond.timeleft = FMODGMS_Util_SamplesToSeconds(FMODGMS_Snd_Get_Length(ins) - FMODGMS_Chan_Get_Position(chi), FMODGMS_Chan_Get_Frequency(chi));