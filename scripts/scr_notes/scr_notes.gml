// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function c_note(t,str,l) constructor {
	position = t;      // position of the note
	type = str;        // note type
	length = l;        // length of the note
	hit = false;       // if the note was hit
	missed = false;    // if the note was missed
	covered = 0;       // how much of the length of the note was covered
	completed = false; // if the hold note was actually finished
	timehit = 0;       // ms at which the note was hit
	special = 0;       // special note type
}

function c_event(t,str,v) constructor {
	position = t;      // position of the event
	type = str;        // type of the event
	value = v;         // value struct of the event
	played = false;    // if the event was played
}

function add_note(list,note) {
	for (var i = 0; i < array_length(list); i += 1) {
		var cur = list[i];
		if cur.position = note.position {
//			show_debug_message("duplicate note");
			return;	
		}
	}
	array_push(list,note);
}

function find_note_in_range(group,column,minn,maxx) {
	var ctr = 0;
	var viablenotes = [];
	var glength = array_length(group[column]);
	for (var i = 0; i < glength; i++) {
		var ourNote = group[column][i];
		var calcPos = cond.notepos - ourNote.position; // position relative to judgement line
		var rmn = ourNote.special > 0 ? minn/2 : minn;
		var rmx = ourNote.special > 0 ? maxx/2 : maxx;
		if (calcPos < rmx) && (calcPos > rmn) && !ourNote.hit && !ourNote.missed {
			// if this is in range, this is a viable note we can hit
			// the note cannot already be hit or missed
			array_push(viablenotes,ourNote);
		}
	}
	if array_length(viablenotes) = 0 { return noone; } // found nothing? return nothing
	else {
		// sort ascending, and return the lowest
		// essentially, this gives us the note at the top of the range
		array_sort(viablenotes,function(note1,note2) {
			if note1.special > 0 { return note2; }
			if note2.special > 0 { return note1; }
			return note1.position - note2.position;
		});
		return viablenotes[0];
	}
	// my best solution to shitty jack timing :)
}

function ovalpha(on) {
	if on {
		gpu_set_alphatestenable(true);
		gpu_set_alphatestref(0);
		gpu_set_blendmode_ext(bm_src_alpha,bm_one);
	}
	else {
		gpu_set_blendmode(bm_normal);
		gpu_set_alphatestenable(false);
	}
}

function clamp_side_and_type(side, type) {
	return (side * global.keyamt) + type;
}