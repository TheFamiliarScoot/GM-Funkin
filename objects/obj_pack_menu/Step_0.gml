if !islua {
	if !instance_exists(obj_transition) {
		if menu.selection < array_length(songs) {
			var song = songs[menu.selection];
			if menu.selection != prevchc {
				if seldifficulty >= array_length(song.difficulties) {
					seldifficulty = 0;
				}
				if seldifficulty < 0 {
					seldifficulty = array_length(song.difficulties) - 1;
				}
			}
			prevchc = menu.selection;

			if input_check_pressed(vk_right) {
				seldifficulty += 1;
				if seldifficulty >= array_length(song.difficulties) {
					seldifficulty = 0;
				}
			}

			if input_check_pressed(vk_left) {
				seldifficulty -= 1;
				if seldifficulty < 0 {
					seldifficulty = array_length(song.difficulties) - 1;
				}
			}	
		}

		if input_check_pressed(vk_enter) {
			if menu.selection < array_length(songs) {
				play_song(songs[menu.selection], songs[menu.selection].difficulties[seldifficulty]);
			}
			else {
				audio_play_sound(snd_menu_cancel, 0, false);
				room_transition(room_entrypoint);
			}
		}	
	}	
}
else {
	call_lua("onMenuStep", id);	
}