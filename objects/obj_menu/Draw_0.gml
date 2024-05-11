image_speed = 0;
draw_self();
if menuenabled {
	switch setupstate {
		case 0:
			switch menu.selection {
				case 0:
					if input_check_pressed(vk_enter, gp_face1) {
						if array_length(packs) = 0 || !directory_exists("assets/songs") {
							play_miss_sfx();	
						}
						setupstate = 1;
						menu.selection = 0;
						var newchoices = [];
						array_copy(newchoices, 0, packs, 0, array_length(packs));
						array_push(newchoices, "back");
						menu.choices = newchoices;
						audio_play_sound(snd_menu_confirm,0,false);
					}
					break;
				case 1:
					if input_check_pressed(vk_enter, gp_face1) {
						room_transition(room_mp_lobby);
						menuenabled = false;
					}
					break;
				case 3:
					if input_check_pressed(vk_enter, gp_face1) {
						room_transition(room_options);
						menuenabled = false;
					}
					break;
				case 4:
					if input_check_pressed(vk_enter, gp_face1) {
						game_end();
					}
					break;
			}
			break;
		case 1:
			if menu.selection >= array_length(packs) {
				if input_check_pressed(vk_enter, gp_face1) {
					setupstate = 0;
					menu.choices = ["pack chooser", "host game", "join game", "options", "exit"];
					menu.selection = 0;
					audio_play_sound(snd_menu_cancel,0,false);
				}
			}
			else {
				if input_check_pressed(vk_enter, gp_face1) {
					global.selectedpack = packs[menu.selection];
					global.packscript = new_lua_state();
					lua_add_file(global.packscript, "assets/songs/" + global.selectedpack + "/pack.lua");
					songs = get_songs_from_current_pack();
					if !is_undefined(songs) && is_array(songs) && array_length(songs) > 0 {
						menu.selection = 0;
						setupstate = 3;
						audio_play_sound(snd_menu_confirm,0,false);
						var newchoices = [];
						for (var i = 0; i < array_length(songs); i += 1) {
							array_push(newchoices, songs[i].name);
						}
						array_push(newchoices, "back");
						lastchoices = menu.choices;
						menu.choices = newchoices;	
					}
					else {
						clear_lua_state(global.packscript);
						play_miss_sfx();
					}
				}
			}
			if input_check_pressed(vk_escape, gp_face2) {
				setupstate = 0;
				menu.choices = [ "pack chooser", "host game", "join game", "options", "exit" ];
				menu.selection = 0;
				audio_play_sound(snd_menu_cancel,0,false);
			}
			break;
		case 2:
			if menu.selection >= array_length(global.selectedsong.difficulties) {
				if input_check_pressed(vk_enter, gp_face1) {
					setupstate = 3;
					var newchoices = [];
					for (var i = 0; i < array_length(songs); i += 1) {
						array_push(newchoices, songs[i].name);
					}
					array_push(newchoices, "back");
					menu.choices = newchoices;
					menu.selection = 0;
					audio_play_sound(snd_menu_cancel,0,false);
				}
			}
			else {
				var difficulties = global.selectedsong.difficulties
			
				var skey = global.selectedsong.name + "-" + difficulties[menu.selection];
				if !ds_exists(global.stats, ds_type_map) { global.stats = try_load_scores("scores.dat") }
				if ds_map_exists(global.stats,skey) {
					var j = json_parse(global.stats[? skey]);

					draw_font_text("Highscore: " + string(j.bestscore),room_width/2,room_height-160,false,40,0.6,true);
					draw_font_text("Highest Combo: " + string(j.bestcombo),room_width/2,room_height-130,false,40,0.6,true);
					draw_font_text("Least Misses: " + string(j.leastmisses),room_width/2,room_height-100,false,40,0.6,true);
					draw_font_text("Highest Accuracy: " + string(j.highestaccuracy),room_width/2,room_height-65,false,40,0.6,true);
					var ratingtext = 
						"Sicks: " + string(j.ratings.sick) + ", " +
						"Goods: " + string(j.ratings.good) + ", " +
						"Bads: " + string(j.ratings.bad) + ", " +
						"Shits: " + string(j.ratings.shit) + ", ";
					draw_font_text(ratingtext,room_width/2,room_height-30,false,40,0.6,true);
				}
				else if deletingstats {
					draw_font_text("Delete these stats?\nPress DEL again to confirm",room_width/2,room_height-100,false,40,0.6,true);	
				}
				else {
					draw_font_text("No stats for this song",room_width/2,room_height-100,false,40,0.6,true);		
				}
				if keyboard_check_pressed(vk_delete) {
					if deletingstats {
						ds_map_delete(global.stats,skey);
						ds_map_secure_save(global.stats,"scores.dat");
						audio_play_sound(snd_menu_confirm,0,false);
						deletingstats = false;
					}
					else {
						deletingstats = true;
					}
				}
				
				if input_check_pressed(vk_enter, gp_face1) {
					var str = "assets/songs/" +
						global.selectedpack +
						"/" +
						global.selectedsong.name +
						"/" +
						difficulty_to_file(global.selectedsong.name,difficulties[menu.selection]);
					//if !file_exists(str) {
					//	play_miss_sfx();
					//}
					//else {
						global.selecteddifficulty = difficulties[menu.selection];
						ini_close();
						menuenabled = false;
						room_transition(room_load);
					//}
				}
			}
			if input_check_pressed(vk_escape, gp_face2) {
				setupstate = 3;
				var newchoices = [];
				for (var i = 0; i < array_length(songs); i += 1) {
					array_push(newchoices, songs[i].name);
				}
				array_push(newchoices, "back");
				menu.choices = newchoices;
				menu.selection = 0;
				audio_play_sound(snd_menu_cancel,0,false);
			}
			break;
		case 3:
			if menu.selection >= array_length(songs) {
				if input_check_pressed(vk_enter, gp_face1) {
					setupstate = 1;
					var newchoices = [];
					array_copy(newchoices, 0, packs, 0, array_length(packs));
					array_push(newchoices, "back");
					menu.choices = newchoices;
					menu.selection = 0;
					audio_play_sound(snd_menu_cancel,0,false);
				}
			}
			else {
				if input_check_pressed(vk_enter, gp_face1) {
					global.selectedsong = songs[menu.selection];
					menu.selection = 0;
					setupstate = 2;
					audio_play_sound(snd_menu_confirm,0,false);
					global.gimmicks = get_gimmicks_song(global.selectedsong.name);
					var newchoices = [];
					for (var i = 0; i < array_length(global.selectedsong.difficulties); i += 1) {
						array_push(newchoices, global.selectedsong.difficulties[i]);
					}
					array_push(newchoices, "back");
					lastchoices = menu.choices;
					menu.choices = newchoices;
				}
			}
			if input_check_pressed(vk_escape, gp_face2) {
				setupstate = 1;
				var newchoices = [];
				array_copy(newchoices, 0, packs, 0, array_length(packs));
				array_push(newchoices, "back");
				menu.choices = newchoices;
				menu.selection = 0;
				clear_lua_state(global.packscript);
				audio_play_sound(snd_menu_cancel,0,false);
			}
			break;
	}
}
timer += 0.25;