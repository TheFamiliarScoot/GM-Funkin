if call_lua_event("onMenuLoad", undefined) {
	sprite_index = spr_menu_bg;
	image_speed = 0;
	image_index = 2;
	
	songs = get_songs_from_current_pack();
	if !is_undefined(songs) && is_array(songs) && array_length(songs) > 0 {
		setupstate = 3;
		var newchoices = [];
		for (var i = 0; i < array_length(songs); i += 1) {
			array_push(newchoices, songs[i].name);
		}
		array_push(newchoices, "exit");
		menu = create_scroll_menu(140, 400, layer, newchoices);
		songchoices = newchoices;
		
		depth = 1;
	}
	else {
		//clear_lua_state(global.packscript);
		//play_miss_sfx();
	}
}

prevchc = 0;
seldifficulty = 0;