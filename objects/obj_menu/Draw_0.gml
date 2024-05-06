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
						room_transition(room_options);
						menuenabled = false;
					}
					break;
				case 2:
					if input_check_pressed(vk_enter, gp_face1) {
						game_end();
					}
					break;
			}
			break;
		case 1:
//			draw_font_text("PACK CHOOSER",room_width/2,200,false,40,1,true);
		
//			draw_font_text("<" + string_upper(packs[current]) + ">",room_width/2,400,false,40,1,true);
			/*
			if input_check_pressed(vk_left, gp_padl) {
				current = (current - 1) % array_length(packs);
				if current < 0 { current = array_length(packs) - 1; }
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if input_check_pressed(vk_right, gp_padr) {
				current = (current + 1) % array_length(packs);
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if input_check_pressed(vk_enter, gp_face1) {
				if !directory_exists("assets/songs/" + packs[current]) {
					play_miss_sfx();
				}
				else {
					global.selectedpack = packs[current];
					songs = get_songs(global.selectedpack);
					current = 0;
					setupstate = 3;
					audio_play_sound(snd_menu_confirm,0,false);
				}
			}
			if input_check_pressed(vk_tab, gp_face4) && !instance_exists(obj_transition) {
				room_transition(room_options);
			}
			if input_check_pressed(vk_escape, gp_face2) {
				setupstate = 0;
				choices = [ "pack chooser", "options", "exit" ];
			}
		
			draw_font_text("TAB/Y: Options",0,global.view_height-40,false,40,0.5);
			*/
			if menu.selection >= array_length(packs) {
				if input_check_pressed(vk_enter, gp_face1) {
					setupstate = 0;
					menu.choices = ["pack chooser", "options", "exit"];
					menu.selection = 0;
					audio_play_sound(snd_menu_cancel,0,false);
				}
			}
			else {
				if input_check_pressed(vk_enter, gp_face1) {
					if !directory_exists("assets/songs/" + packs[menu.selection]) {
						play_miss_sfx();
					}
					else {
						global.selectedpack = packs[menu.selection];
						songs = get_songs(global.selectedpack);
						menu.selection = 0;
						setupstate = 3;
						audio_play_sound(snd_menu_confirm,0,false);
						global.gimmicks = get_gimmicks_pack(global.selectedpack);
						global.cursongstate = new_lua_state();
						var scriptpath = "assets/songs/" + packs[menu.selection] + "/script.lua";
						if file_exists(scriptpath)
							lua_add_file(global.cursongstate, scriptpath);
						var newchoices = [];
						for (var i = 0; i < array_length(songs); i += 1) {
							array_push(newchoices, songs[i].name);
						}
						array_push(newchoices, "back");
						lastchoices = menu.choices;
						menu.choices = newchoices;
					}
				}
			}
			if input_check_pressed(vk_escape, gp_face2) {
				setupstate = 0;
				menu.choices = [ "pack chooser", "options", "exit" ];
				menu.selection = 0;
				audio_play_sound(snd_menu_cancel,0,false);
			}
			break;
		case 2:
			/*
			draw_font_text("DIFFICULTY",room_width/2,200,false,40,1,true);
			var difficulties = global.selectedsong.difficulties
			
			var skey = global.selectedsong.name + "-" + difficulties[current];
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
		
			draw_font_text("<" + string_upper(difficulties[current]) + ">",room_width/2,400,false,40,1,true);
			if input_check_pressed(vk_left, gp_padl) {
				current = (current - 1) % array_length(difficulties);
				if current < 0 { current = array_length(difficulties) - 1; }
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if input_check_pressed(vk_right, gp_padr) {
				current = (current + 1) % array_length(difficulties);
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if input_check_pressed(vk_enter, gp_face1) {
				var str = "assets/songs/" +
					global.selectedpack +
					"/" +
					global.selectedsong.name +
					"/" +
					difficulty_to_file(global.selectedsong.name,difficulties[current]);
				if !file_exists(str) {
					play_miss_sfx();
				}
				else {
					global.selecteddifficulty = difficulties[current];
					ini_close();
					menuenabled = false;
					room_transition(room_play);
				}
			}
			if input_check_pressed(vk_escape, gp_face2) {
				audio_play_sound(snd_menu_cancel,0,false);
				current = 0;
				setupstate = 3;
				ds_map_destroy(global.stats);
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
			*/
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
					if !file_exists(str) {
						play_miss_sfx();
					}
					else {
						global.selecteddifficulty = difficulties[menu.selection];
						ini_close();
						menuenabled = false;
						room_transition(room_play);
					}
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
			/*
			draw_font_text("SONG CHOOSER",room_width/2,200,false,40,1,true);
		
			draw_font_text("<" + string_upper(songs[current].name) + ">",room_width/2,400,false,40,1,true);
			if input_check_pressed(vk_left, gp_padl) {
				current = (current - 1) % array_length(songs);
				if current < 0 { current = array_length(songs) - 1; }
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if input_check_pressed(vk_right, gp_padr) {
				current = (current + 1) % array_length(songs);
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if input_check_pressed(vk_enter, gp_face1) {
				if !directory_exists("assets/songs/" + global.selectedpack + "/" + songs[current].name) {
					play_miss_sfx();	
				}
				else {
					global.selectedsong = songs[current];
					current = 0;
					setupstate = 2;
				}
			}
			if input_check_pressed(vk_escape, gp_face2) {
				audio_play_sound(snd_menu_cancel,0,false);
				current = 0;
				setupstate = 1;
			}
			*/
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
					if !directory_exists("assets/songs/" + global.selectedpack + "/" + songs[current].name) {
						play_miss_sfx();	
					}
					else {
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
			}
			if input_check_pressed(vk_escape, gp_face2) {
				setupstate = 1;
				var newchoices = [];
				array_copy(newchoices, 0, packs, 0, array_length(packs));
				array_push(newchoices, "back");
				menu.choices = newchoices;
				menu.selection = 0;
				lua_state_destroy(global.cursongstate);
				audio_play_sound(snd_menu_cancel,0,false);
			}
			break;
	}
}
timer += 0.25;