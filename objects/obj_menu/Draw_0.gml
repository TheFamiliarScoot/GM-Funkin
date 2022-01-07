
image_speed = 0;
draw_self();
if menuenabled {
	switch setupstate {
		case 1:
			draw_font_text("PACK CHOOSER",room_width/2,200,false,40,1,true);
		
			draw_font_text("<" + string_upper(packs[current]) + ">",room_width/2,400,false,40,1,true);
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
		
			draw_font_text("TAB/Y: Options",0,global.view_height-40,false,40,0.5);
			break;
		case 2:
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
			break;
		case 3:
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
			break;
	}
}
timer += 0.25;