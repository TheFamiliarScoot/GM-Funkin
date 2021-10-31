var p = global.pixelui;

var leniency = global.options.inputleniency * clamp(global.realscroll,1,1.5);
var key = type % 4;
var opponentcheck = (isbot && find_note_in_range(global.sections, cond.section, group, key, 0, 500) != noone);
if (keyboard_check_pressed(thisKey) && !isbot) || opponentcheck {
	if isbot { lastnote = find_note_in_range(global.sections,cond.section,group,key, 0, 500); }
	else { lastnote = find_note_in_range(global.sections,cond.section,group,key, -leniency, leniency); }
	if lastnote != noone {
		if !(isbot && lastnote.special > 0) {
			var k = type % 4;
			var the = cond.notepos - lastnote.position;
			play_anim_d(id,nsprite[p][2]);
			if !isbot && !(lastnote.special > 0) {
	//			show_debug_message(string(the) + " - " + check_rating(the));
				global.combo += 1;
				rate(the);		
				show_debug_message(global.combo);
			}
			if lastnote.special > 0 {
				switch lastnote.special {
					case 1:
						with tiedCharacter event_user(k + 4);
						obj_conductor.vocalsmuted = true;
						change_hp(-0.2);
						break;
					case 2:
						with tiedCharacter event_user(k);
						obj_conductor.vocalsmuted = false;
						change_hp(0.2);
						break;
				}
			}
			else {
				obj_conductor.vocalsmuted = false;
				with tiedCharacter {
					event_user(k);
				}
			}
			lastnote.hit = true;
			lastnote.timehit = the;
			if isbot { 
				d_alarm[0] = 20;
				obj_conductor.vocalsmuted = false;
			}
		}
	}
	else {
		play_anim_d(id,nsprite[p][1]);
		if !global.options.ghosttapping && !isbot { 
			miss(tiedCharacter,-0.04,key);
		}
	}
}
if keyboard_check(thisKey) || (isbot && lastnote != noone && lastnote.length > 0) {
	if lastnote != noone {
		var k = type % 4;
		if !(lastnote.length < 0) && !(lastnote.covered >= lastnote.length) {
			lastnote.covered += cond.notepos - lasttime;
			with tiedCharacter { event_user(k); }
		}
		else { lastnote.completed = true; }
	}
}
if !isbot && keyboard_check_released(thisKey) {
	var k = type % 4;
	if lastnote != noone {
		// leniency check - lets you off if you at least covered MOST of the note
		if lastnote.length - lastnote.covered < 100 { lastnote.completed = true; }
		else if global.options.missnotes {
			miss(tiedCharacter,-0.075,key);
			lastnote.missed = true;
		}
		lastnote = noone;
	}
	
	play_anim_d(id,nsprite[p][5]);
}
lasttime = cond.notepos;