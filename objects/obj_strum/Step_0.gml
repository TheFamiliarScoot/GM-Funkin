if !instance_exists(conductor) {
	return;	
}

var p = global.pixelui;

var leniency = global.options.inputleniency * clamp(global.realscroll,1,1.5);
var key = type % 4;
var opponentcheck = (isbot && find_note_in_range(conductor, clamp_side_and_type(group, key, conductor.keyamt), 0, 500) != noone);
if (input_check_pressed(thisKey, thisKeyGP) && !isbot) || opponentcheck {
	if isbot { lastnote = find_note_in_range(conductor, clamp_side_and_type(group, key, conductor.keyamt), 0, 500); }
	else { lastnote = find_note_in_range(conductor, clamp_side_and_type(group, key, conductor.keyamt), -leniency, leniency); }
	if lastnote != noone {
//		var spec = opt.notetypes[lastnote.special + 1];
		if !(isbot && lastnote.special > 0) {
			var k = type % 4;
			var the = conductor.notepos - lastnote.position;
			play_anim_d(id,nsprite[p][2]);
			if variable_struct_exists(global.gimmicks,"opponent_deals_damage") {
				if global.gimmicks.opponent_deals_damage && opponentcheck {
					change_hp(-0.02,false);
				}
			}
			if !isbot && !(lastnote.special > 0) {
	//			show_debug_message(string(the) + " - " + check_rating(the));
				global.combo += 1;
				if global.combo > global.highcombo {
					global.highcombo = global.combo;
				}
				rate(the);
				if lastnote.length <= 0 {
					global.notesplayed += 1;
					global.noteshit += 1;
					recalc_accuracy();
				}
			}
			if lastnote.special > 0 {
				switch lastnote.special {
					case 1:
						with tiedCharacter event_user(k + 4);
						if instance_exists(conductor) conductor.vocalsmuted[tiedCharacter.playside] = true;
						change_hp(-0.2);
						break;
					case 2:
						with tiedCharacter event_user(k);
						if instance_exists(conductor) conductor.vocalsmuted[tiedCharacter.playside] = false;
						change_hp(0.2);
						break;
					case 3:
//						with tiedCharacter event_user(k + 4);
						if instance_exists(conductor) conductor.vocalsmuted[tiedCharacter.playside] = false;
//						change_hp(-0.2);
						break;
					case 4:
						die();
						break;
				}
			}
			else {
				if instance_exists(conductor) conductor.vocalsmuted[tiedCharacter.playside] = false;
				with tiedCharacter {
					event_user(k);
				}
			}
			lastnote.hit = true;
			lastnote.timehit = the;
			if isbot { 
				d_alarm[0] = 20;
				if instance_exists(conductor) conductor.vocalsmuted[tiedCharacter.playside] = false;
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
if input_check(thisKey, thisKeyGP) || (isbot && lastnote != noone && lastnote.length > 0) {
	if lastnote != noone {
		var k = type % 4;
		if !(lastnote.length < 0) && !(lastnote.covered >= lastnote.length) {
			lastnote.covered += conductor.notepos - lasttime;
			with tiedCharacter { event_user(k); }
		}
		else { 
			lastnote.completed = true;
		}
	}
}
if !isbot && input_check_released(thisKey, thisKeyGP) {
	var k = type % 4;
	if lastnote != noone {
		// leniency check - lets you off if you at least covered MOST of the note
		if lastnote.length - lastnote.covered < 100 { 
			lastnote.completed = true;
			if lastnote.length > 0 {
				global.noteshit += 1;				
			}
		}
		else if global.options.missnotes {
			miss(tiedCharacter,-0.075,key);
			lastnote.missed = true;
		}
		if lastnote.length > 0 {
			global.notesplayed += 1;
			recalc_accuracy();
		}
		lastnote = noone;
	}
	
	play_anim_d(id,nsprite[p][5]);
}
lasttime = conductor.notepos;