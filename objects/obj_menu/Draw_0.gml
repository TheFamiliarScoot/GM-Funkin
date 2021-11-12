
image_speed = 0;
draw_self();
if menuenabled {
	switch setupstate {
		case 1:
			draw_font_text("PACK CHOOSER",room_width/2,200,false,40,1,true);
		
			draw_font_text("<" + string_upper(packs[current]) + ">",room_width/2,400,false,40,1,true);
			if keyboard_check_pressed(vk_left) {
				current = (current - 1) % array_length(packs);
				if current < 0 { current = array_length(packs) - 1; }
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if keyboard_check_pressed(vk_right) {
				current = (current + 1) % array_length(packs);
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if keyboard_check_pressed(vk_enter) {
				if !directory_exists("assets/songs/" + packs[current]) {
					play_miss_sfx();
				}
				else {
					global.selectedpack = packs[current];
					songs = read_text("assets/songs/" + packs[current] + "/songlist.txt");
					current = 0;
					setupstate = 3;
					audio_play_sound(snd_menu_confirm,0,false);
				}
			}
			if keyboard_check_pressed(vk_tab) && !instance_exists(obj_transition) {
				room_transition(room_options);
			}
			if keyboard_check_pressed(vk_escape) {
				game_end();
			}
		
			draw_font_text("TAB: Options",0,global.view_height-40,false,40,0.5);
			break;
		case 2:
			draw_font_text("DIFFICULTY",room_width/2,200,false,40,1,true);
			var difficulties = ["easy","normal","hard"];
			
			var skey = global.selectedsong + "-" + difficulties[current];
			if ds_map_exists(stats,skey) {
				var j = json_parse(stats[? skey]);

				draw_font_text("Highscore: " + string(j.bestscore),room_width/2,room_height-100,false,40,0.6,true);
				draw_font_text("Highest Combo: " + string(j.bestcombo),room_width/2,room_height-65,false,40,0.6,true);
				draw_font_text("Least Misses: " + string(j.leastmisses),room_width/2,room_height-30,false,40,0.6,true);
			}
			else {
				draw_font_text("No stats for this song",room_width/2,room_height-100,false,40,0.6,true);
			}
		
			draw_font_text("<" + string_upper(difficulties[current]) + ">",room_width/2,400,false,40,1,true);
			if keyboard_check_pressed(vk_left) {
				current = (current - 1) % array_length(difficulties);
				if current < 0 { current = array_length(difficulties) - 1; }
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if keyboard_check_pressed(vk_right) {
				current = (current + 1) % array_length(difficulties);
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if keyboard_check_pressed(vk_enter) {
				var str = "assets/songs/" +
					global.selectedpack +
					"/" +
					global.selectedsong +
					"/" +
					difficulty_to_file(global.selectedsong,difficulties[current]);
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
			if keyboard_check_pressed(vk_escape) {
				audio_play_sound(snd_menu_cancel,0,false);
				current = 0;
				setupstate = 3;
				ds_map_destroy(stats);
			}
			break;
		case 3:
			draw_font_text("SONG CHOOSER",room_width/2,200,false,40,1,true);
		
			draw_font_text("<" + string_upper(songs[current]) + ">",room_width/2,400,false,40,1,true);
			if keyboard_check_pressed(vk_left) {
				current = (current - 1) % array_length(songs);
				if current < 0 { current = array_length(songs) - 1; }
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if keyboard_check_pressed(vk_right) {
				current = (current + 1) % array_length(songs);
				audio_play_sound(snd_menu_scroll,0,false);
			}
			if keyboard_check_pressed(vk_enter) {
				if !directory_exists("assets/songs/" + global.selectedpack + "/" + songs[current]) {
					play_miss_sfx();	
				}
				else {
					global.selectedsong = songs[current];
					current = 0;
					setupstate = 2;
					stats = ds_map_secure_load("scores.dat");
				}
			}
			if keyboard_check_pressed(vk_escape) {
				audio_play_sound(snd_menu_cancel,0,false);
				current = 0;
				setupstate = 1;
			}
			break;
	}
}
timer += 0.25;