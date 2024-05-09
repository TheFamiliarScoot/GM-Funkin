function init_conductor(pack, song, difficulty) {
	cond = {}
	switch song.chartType {
		case "old":
			load_chart_old(pack, song, difficulty);
			break;
		case "funkinv3":
			load_chart_funkin_v3(pack, song, difficulty);
			break;
	}
	cond.crochet = 60 / cond.bpm;
	cond.lastpos = -cond.crochet * 4;
	cond.songpos = -cond.crochet * 4;
	cond.notepos = (-cond.crochet * 4) * 1000;
	cond.gbeat = 0;
	cond.gstep = 0;
	cond.cbeat = 0;
	cond.cstep = 0;
	cond.beathit = false;
	cond.stephit = false;
	cond.timeleft = 0;
}

function load_chart_old(pack, song, difficulty) {
	var diffaddstring = "-" + difficulty;
	if difficulty == "normal" { diffaddstring = ""; }
	var jsonlocation = "assets\\songs\\" + pack + "\\" + song.fileName + "\\" + song.fileName + diffaddstring + ".json";
	var chrt = read_json(jsonlocation);

	var totalnotecount = 0;
	var cursteps = 0;
	var curbpm = chrt.song.bpm;
	var curpos = 0;
	var lastswap = -1;

	var donotechecks = false;

	var strums = global.keyamt * 2;
	
	repeat strums {
		array_push(global.notes, []);	
	}
	
	try {
		for (var h = 0; h < array_length(chrt.song.notes); h += 1) {	
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
				if swap != lastswap {
					var ch = swap ? 0 : 1;
					if ch == 0 && variable_struct_exists(chrt.song.notes[h], "gfSection") && chrt.song.notes[h].gfSection { ch = 2; }
					array_push(global.events, new c_event(curpos, "FocusCamera", { char: ch }));
				}
				lastswap = swap;
				
				if variable_struct_exists(chrt.song.notes[h], "changeBPM") && chrt.song.notes[h].changeBPM {
					array_push(global.events, new c_event(curpos, "ChangeTime", { bpm: chrt.song.notes[h].bpm, n: 4, d: 4 }))	
				}
		
				if len < 0 { len = 0 };	
		
				var thisNote = new c_note(pos,typ,len);
		
				thisNote.special = nspecial;
		
				var rt = (typ + global.keyamt) % global.keyamt;
				var side = floor(typ / global.keyamt) % 2;
				if swap ? side : !side {
					rt += global.keyamt;
				}
				add_note(global.notes[rt], thisNote);
				totalnotecount += 1;
			}
			var dsteps = chrt.song.notes[h].lengthInSteps;
			cursteps += dsteps;
			curpos += (60 / curbpm) * (dsteps / 4) * 1000;
		}
	}
	catch (e) {
		var msg = "Could not load the chart :(\n\nTHIS IS NOT A CRASH!\n\n"
		+ e.longMessage;
		show_message(msg);
		instance_deactivate_all(false);
		room_goto(room_menu);
		return -1;
	}

	var songlocation = "assets\\songs\\" + pack + "\\" + song.instLocation;
	if !file_exists(songlocation) {
		show_message("Couldn't find the instrumental! :(");
		room_goto(room_menu);
		return -1;
	}
	ins = fmod_system_create_stream(songlocation, FMOD_MODE.LOOP_OFF);
	voc = [];
	var voicesloc = "assets\\songs\\" + pack + "\\" + song.voicesLocations[1];
	if file_exists(voicesloc) { voc2 = fmod_system_create_stream(voicesloc, FMOD_MODE.LOOP_OFF); }
	else { voc2 = -1 }
	voc1 = -1;

	obj_conductor.vocalsmuted = [false, false];
	
	cond.scrollspeed = chrt.song.speed;
	cond.bpm = chrt.song.bpm;
	cond.timedenominator = 4;
	cond.timenumerator = 4;	
	cond.offset = -10;
}

function load_chart_funkin_v3(pack, song, difficulty) {
	var metadata = read_json("assets\\songs\\" + pack + "\\" + song.fileName + "\\" + song.fileName + "-metadata.json");
	var chart = read_json("assets\\songs\\" + pack + "\\" + song.fileName + "\\" + song.fileName + "-chart.json");
	
	for (var i = 0; i < array_length(chart.events); i++) {
		var ev = chart.events[i];
		add_note(global.events, new c_event(ev.t, ev.e, ev.v));
	}
	
	var strums = global.keyamt * 2;
	repeat strums {
		array_push(global.notes, []);	
	}
	
	var notes = variable_struct_get(chart.notes, difficulty);
	for (var i = 0; i < array_length(notes); i++) {
		var note = notes[i];
		add_note(global.notes[note.d], new c_note(note.t, note.d, note.l));
	}
	
	var songlocation = "assets\\songs\\" + pack + "\\" + song.instLocation;
	if !file_exists(songlocation) {
		show_message("Couldn't find the instrumental! :(");
		room_goto(room_menu);
		return -1;
	}
	ins = fmod_system_create_stream(songlocation, FMOD_MODE.LOOP_OFF);
	
	voc = [];
	var voices1loc = "assets\\songs\\" + pack + "\\" + song.voicesLocations[0];
	if file_exists(voices1loc) { voc1 = fmod_system_create_stream(voices1loc, FMOD_MODE.LOOP_OFF); }
	else { voc1 = -1 }
	var voices2loc = "assets\\songs\\" + pack + "\\" + song.voicesLocations[1];
	if file_exists(voices2loc) { voc2 = fmod_system_create_stream(voices2loc, FMOD_MODE.LOOP_OFF); }
	else { voc2 = -1 }
	
	obj_conductor.vocalsmuted = [false, false];
	
	cond.scrollspeed = variable_struct_get(chart.scrollSpeed, difficulty);
	cond.bpm = metadata.timeChanges[0].bpm;
	cond.timedenominator = metadata.timeChanges[0].d;
	cond.timenumerator = metadata.timeChanges[0].n;
	cond.offset = metadata.offsets.instrumental;
}