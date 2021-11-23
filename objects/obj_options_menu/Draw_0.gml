draw_self();
draw_font_text(title,room_width/2,40+ybegin,true,40,1,true);

if opt.scrollspeed = 0 { ss = "USE CHART'S"; }
else { ss = string(opt.scrollspeed)	}

switch submenu {
	case 10: // main
		switch selection {
			case 0: // keybinds
				if input_check_pressed(vk_enter, gp_face1) { 
					submenu = 11;
					title = "KEYBINDS";
					selection = 0;
					ybegin = 160;
					var file = working_directory + "keybinds.ini";
					ini_open(file);
					keybind = {up: ord("W"), down: ord("S"), left: ord("A"), right: ord("D")}
					keybind.up = ini_read_real("Keys","Up",ord("W"));
					keybind.down = ini_read_real("Keys","Down",ord("S"));
					keybind.left = ini_read_real("Keys","Left",ord("A"));
					keybind.right = ini_read_real("Keys","Right",ord("D"));
				}
				break;
			case 1: // gameplay
				if input_check_pressed(vk_enter, gp_face1) {
					title = "GAMEPLAY";
					submenu = 12;
					selection = 0;
					ybegin = 15;
				}
				break;
			case 2: // appearance
				if input_check_pressed(vk_enter, gp_face1) {
					title = "APPEARANCE";
					submenu = 13;
					selection = 0;
					ybegin = 120;
				}
				break;
		}
		break;
	case 11: // keybinds
		if input_check_pressed(vk_enter, gp_face1) && !changing {
			changing = true;
			switch selection {
				case 0: previouskey = keybind.left; keybind.left = 0; break;
				case 1: previouskey = keybind.down; keybind.down = 0; break;
				case 2: previouskey = keybind.up; keybind.up = 0; break;
				case 3: previouskey = keybind.right; keybind.right = 0; break;
			}
		}
		if input_lastkey != -1 && changing && input_lastkey != vk_enter && input_lastkey != vk_escape {
			newkey = input_lastkey;
			input_lastkey = -1;
			switch selection {
				case 0: keybind.left = newkey; break;
				case 1: keybind.down = newkey; break;
				case 2: keybind.up = newkey; break;
				case 3: keybind.right = newkey; break;
			}
			changing = false;
		}
		break;
	case 12: // gameplay
		switch selection {
			case 0:
				if input_check_pressed(vk_enter, gp_face1) { submenu = 16; }
				break;
			case 1:
				if input_check_pressed(vk_right, gp_padr) { opt.scrollspeed += 0.1; }
				if input_check_pressed(vk_left, gp_padl) { opt.scrollspeed -= 0.1; }
				if opt.scrollspeed > 4 { opt.scrollspeed = 4; }
				if opt.scrollspeed < 0 { opt.scrollspeed = 0; }
				break;
			case 2:
				if input_check_pressed(vk_enter, gp_face1) { opt.usedownscroll = !opt.usedownscroll; }
				break;
			case 3:
				if input_check_pressed(vk_enter, gp_face1) { opt.ghosttapping = !opt.ghosttapping; }
				break;
			case 4:
				if input_check_pressed(vk_enter, gp_face1) { opt.missnotes = !opt.missnotes; }
				break;
			case 5:
				if input_check_pressed(vk_enter, gp_face1) { opt.blueballing = !opt.blueballing; }
				break;
			case 6:
				if input_check_pressed(vk_enter, gp_face1) { opt.retrykey = !opt.retrykey; }
				break;
			case 7:
				if input_check_pressed(vk_enter, gp_face1) { opt.player1 = !opt.player1; }
				break;
			case 8:
				if input_check_pressed(vk_enter, gp_face1) { opt.botplay = !opt.botplay; }
				break;
			case 9:
				if input_check_pressed(vk_enter, gp_face1) { opt.middlescroll = !opt.middlescroll; }
				break;
			case 10:
				if input_check_pressed(vk_enter, gp_face1) {
					title = "SPECIAL NOTES";
					selection = 0;
					ybegin = 100;
					submenu = 17;
				}
				break;
		}
		break;
	case 13: // appearance
		switch selection {
			case 0:
				if input_check_pressed(vk_enter, gp_face1) {
					title = "IN-GAME OPTIONS";
					submenu = 14;
					selection = 0;
					bf = opt.customization.bfobject;
					gf = opt.customization.gfobject;
					dad = opt.customization.dadobject;
					stage = opt.customization.bgobject;
					selectpreset = opt.customization.preset;
				}
				break;
			case 1:
				if input_check_pressed(vk_enter, gp_face1) { opt.antialiasing = !opt.antialiasing; }
				break;
			case 2:
				if input_check_pressed(vk_enter, gp_face1) { opt.specialcolors = !opt.specialcolors; }
				break;
			case 3:
				if input_check_pressed(vk_enter, gp_face1) { opt.nobg = !opt.nobg; }
				break;
			case 4:
				if input_check_pressed(vk_enter, gp_face1) { opt.timedisplay = !opt.timedisplay; }
				break;
			case 5:
				if input_check_pressed(vk_enter, gp_face1) {
					title = "NOTE SKINS";
					submenu = 15;
					selection = 0;
				}
				break;
		}
		break;
	case 14: // in-game options
		if opt.customization.usepreset {
			switch selection {
				case 0:
					if input_check_pressed(vk_enter, gp_face1) { opt.customization.usepreset = !opt.customization.usepreset; }
					break;
				case 1:
					if input_check_pressed(vk_right, gp_padr) { selectpreset += 1; }
					if input_check_pressed(vk_left, gp_padl) { selectpreset -= 1; }
					if selectpreset > array_length(presets) - 1 { selectpreset = 0; }
					if selectpreset < 0 { selectpreset = array_length(presets) - 1; }
					break;
			}
		}
		else {
			switch selection {
				case 0:
					if input_check_pressed(vk_enter, gp_face1) { opt.customization.usepreset = !opt.customization.usepreset; }
					break;
				case 1:
					if input_check_pressed(vk_right, gp_padr) { stage += 1; }
					if input_check_pressed(vk_left, gp_padl) { stage -= 1; }
					if stage > array_length(stages) - 1 { stage = 0; }
					if stage < 0 { stage = array_length(stages) - 1; }
					break;
				case 2:
					if input_check_pressed(vk_right, gp_padr) { dad += 1; }
					if input_check_pressed(vk_left, gp_padl) { dad -= 1; }
					if dad > array_length(characters) - 1 { dad = 0; }
					if dad < 0 { dad = array_length(characters) - 1; }
					break;
				case 3:
					if input_check_pressed(vk_right, gp_padr) { bf += 1; }
					if input_check_pressed(vk_left, gp_padl) { bf -= 1; }
					if bf > array_length(characters) - 1 { bf = 0; }
					if bf < 0 { bf = array_length(characters) - 1; }
					break;
				case 4:
					if input_check_pressed(vk_right, gp_padr) { gf += 1; }
					if input_check_pressed(vk_left, gp_padl) { gf -= 1; }
					if gf > array_length(characters) - 1 { gf = 0; }
					if gf < 0 { gf = array_length(characters) - 1; }
					break;
			}
		}
		break;
	case 15: // note skins
		switch selection {
			case 0:
				if input_check_pressed(vk_enter, gp_face1) { opt.usenoteskin = !opt.usenoteskin; }
				break;
			case 1:
				if input_check_pressed(vk_right, gp_padr) { opt.noteskin += 1; }
				if input_check_pressed(vk_left, gp_padl) { opt.noteskin -= 1; }
				if opt.noteskin > array_length(global.noteskins) - 1 { opt.noteskin = 0; }
				if opt.noteskin < 0 { opt.noteskin = array_length(global.noteskins) - 1; }
				break;
		}
		break;
	case 16: // gameplay page 2
		switch selection {
			case 0:
				if input_check_pressed(vk_enter, gp_face1) { 
					submenu = 12;
				}
				break;
			case 1:
				if input_check_pressed(vk_right, gp_padr) { opt.hpmult += 0.1; }
				if input_check_pressed(vk_left, gp_padl) { opt.hpmult -= 0.1; }
				if opt.hpmult > 5 { opt.hpmult = 5; }
				if opt.hpmult < 0 { opt.hpmult = 0; }
				break;
			case 2:
				if input_check_pressed(vk_right, gp_padr) { opt.hpgainmult += 0.1; }
				if input_check_pressed(vk_left, gp_padl) { opt.hpgainmult -= 0.1; }
				if opt.hpgainmult > 5 { opt.hpgainmult = 5; }
				if opt.hpgainmult < 0 { opt.hpgainmult = 0; }
				break;
		}
		break;
	case 17: // special note customization
		switch (selection) {
			case 0:
				if input_check_pressed(vk_enter, gp_face1) { opt.specialnotes = !opt.specialnotes; }
				break;
			case 1:
				if input_check_pressed(vk_enter, gp_face1) { opt.snoteinstakill = !opt.snoteinstakill; }
				break;
			case 2:
			case 3:
			case 4:
			case 5:
			case 6:
				if input_check_pressed(vk_left, gp_padl) { opt.notetypes[selection - 2] -= 1; }
				if input_check_pressed(vk_right, gp_padr) { opt.notetypes[selection - 2] += 1; }
				if selection > 0 {
					if opt.notetypes[selection - 2] > 3 { opt.notetypes[selection - 2] = 3; }
					if opt.notetypes[selection - 2] < -1 { opt.notetypes[selection - 2] = -1; }
				}
				break;
		}
		break;
		
}

switch submenu {
	case 10:
		choices = [
			"KEYBINDS",
			"GAMEPLAY",
			"APPEARANCE"
		];
		break;
	case 11:
		choices = [
			"KEY LEFT: " + key_to_string(keybind.left),
			"KEY DOWN: " + key_to_string(keybind.down),
			"KEY UP: " + key_to_string(keybind.up),
			"KEY RIGHT: " + key_to_string(keybind.right)
		];
		break;
	case 12:
		choices = [
			"PAGE 1",
			"SCROLL SPEED: " + ss,
			"DOWNSCROLL: " + bool_onoff(opt.usedownscroll),
			"GHOST TAPPING: " + bool_onoff(opt.ghosttapping),
			"MISS NOTES?: " + bool_yesno(opt.missnotes),
			"BLUEBALLING: " + bool_onoff(opt.blueballing),
			"RETRY KEY:" + bool_onoff(opt.retrykey),
			"PLAY AS P1: " + bool_yesno(opt.player1),
			"BOTPLAY: " + bool_onoff(opt.botplay),
			"MIDDLESCROLL: " + bool_onoff(opt.middlescroll),
			"SPECIAL NOTES"
		]
		break;
	case 13:
		choices = [
			"IN-GAME OPTIONS",
			"ANTIALIASING: " + bool_onoff(opt.antialiasing),
			"HEALTH BAR COLORS: " + bool_onoff(opt.specialcolors),
			"NO BACKGROUND: " + bool_yesno(opt.nobg),
			"TIME DISPLAY: " + bool_onoff(opt.timedisplay),
			"NOTE SKINS"
		];
		break;
	case 14:
		if opt.customization.usepreset {
			choices = [
				"USE PRESET: YES",
				"PRESET: " + string_upper(presets[selectpreset])
			];
		}
		else {
			choices = [
				"USE PRESET: NO",
				"STAGE: " + stages[stage],
				"LEFT: " + characters[dad],
				"RIGHT: " + characters[bf],
				"MIDDLE: " + characters[gf]
			];
		}
		break;
	case 15:
		choices = [
			"USE NOTE SKIN: " + bool_yesno(opt.usenoteskin),
			"NOTE SKIN: " + string_upper(global.noteskins[opt.noteskin])
		];
		break;
	case 16:
		choices = [
			"PAGE 2",
			"HEALTH PENALTY MULTIPLIER: " + string(opt.hpmult) + "x",
			"HEALTH GAIN MULTIPLIER: " + string(opt.hpgainmult) + "x"
		]
		break;
	case 17:
		choices = [
			"ENABLED: " + bool_yesno(opt.specialnotes),
			"INSTAKILL: " + bool_onoff(opt.snoteinstakill),
			"NOTE TYPE 1: " + specialnote_to_string(opt.notetypes[0]),
			"NOTE TYPE 2: " + specialnote_to_string(opt.notetypes[1]),
			"NOTE TYPE 3: " + specialnote_to_string(opt.notetypes[2]),
			"NOTE TYPE 4: " + specialnote_to_string(opt.notetypes[3]),
			"NOTE TYPE 5: " + specialnote_to_string(opt.notetypes[4])
		]
		break;
}

for (var i = 0; i < array_length(choices); i += 1) {
	draw_font_text(choices[i],room_width/2,120+(i*55)+ybegin,false,40,0.8,true);	
}

draw_font_text("> " + string_repeat(" ",string_length(choices[selection])) + " <",room_width/2,120+(selection*55)+ybegin,false,40,0.9,true);

if input_check_pressed(vk_down, gp_padd) && !changing { selection += 1; audio_play_sound(snd_menu_scroll,0,false); }
if input_check_pressed(vk_up, gp_padu) && !changing { selection -= 1; audio_play_sound(snd_menu_scroll,0,false) }
if selection > array_length(choices) - 1 { selection = 0; }
if selection < 0 { selection = array_length(choices) - 1; }

if input_check_pressed(vk_escape, gp_face2) && !instance_exists(obj_transition) {
	if changing {
		switch selection {
			case 0: keybind.left = previouskey; break;
			case 1: keybind.down = previouskey; break;
			case 2: keybind.up = previouskey; break;
			case 3: keybind.right = previouskey; break;
		}
		changing = false;
	}
	else {
		switch submenu {
			case 10:
				room_transition(room_menu);
				audio_play_sound(snd_menu_cancel,0,false);
				write_save(working_directory + "options.json");
				break;
			case 11:
				ini_write_real("Keys","Up",keybind.up);
				ini_write_real("Keys","Down",keybind.down);
				ini_write_real("Keys","Left",keybind.left);
				ini_write_real("Keys","Right",keybind.right);
				ini_close();
				selection = 0;
				title = "OPTIONS";
				submenu = 10;
				ybegin = 180;
				break;
			case 12:
				selection = 0;
				title = "OPTIONS";
				submenu = 10;
				ybegin = 180;
				break;
			case 13:
				selection = 0;
				title = "OPTIONS";
				submenu = 10;
				ybegin = 180;
				break;
			case 14:
				opt.customization.preset = selectpreset;
				opt.customization.dadobject = dad;
				opt.customization.bfobject = bf;
				opt.customization.gfobject = gf;
				opt.customization.bgobject = stage;
				selection = 0;
				title = "APPEARANCE";
				submenu = 13;
				ybegin = 120;
				break;
			case 15:
				global.curnoteskin = global.noteskins[opt.noteskin];
				selection = 0;
				title = "APPEARANCE";
				submenu = 13;
				ybegin = 120;
				break;
			case 16:
				selection = 0;
				title = "OPTIONS";
				submenu = 10;
				ybegin = 180;
				break;
			case 17:
				selection = 0;
				title = "GAMEPLAY";
				ybegin = 15;
				submenu = 12;
				break;
		}
	}
}